import processing.video.*;
import jp.nyatla.nyar4psg.*;
import oscP5.*;
import netP5.*;
import controlP5.*;

CircularBuffer buf;
COMM comm;
Capture cam;
MultiMarker nya;
OscP5 oscP5;

int window_x = 640;
int window_y = 480;

boolean isSetuped = true;
int markersNum = 8;
boolean interpolate = true; //whether to interpolate values between marker detected positions - results in interpolateer movement

void setup() {
  //Basic setting
  size(640, 480, P3D);
  surface.setTitle("Marker detection");

  println(MultiMarker.VERSION);

  initGUI();

  buf = new CircularBuffer(20);
  comm = new COMM();
  nya=new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  for (int i = 0; i < markersNum; i++) {
    nya.addNyIdMarker(i, 80);
  }


  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    try {
      cam=new Capture(this, window_x, window_y);
    }
    catch(IllegalStateException e) {
      isSetuped = false;
      println("No device available!");
    }
  } else {
    printArray(cameras);
    cam = new Capture(this, cameras[camIndex]);
    currentCamName = cameras[camIndex];
    isSetuped = true;
    //start camera capture
    cam.start(); //note that his might lead to program error if the gstreamer encounter some fatal problem such as internal data stream error
  }
}

void draw()
{
  if (!isSetuped) {
    if ((cameras = checkCameraList()) != null) {
      isSetuped = true;
    }
  } else {
    if (cam.available() !=true) {
      return;
    }
    cam.read();
    nya.detect(cam);
    background(0);
    nya.drawBackground(cam);
    for (int i=0; i<markersNum; i++) {
      if ((nya.isExist(i))) {

        boolean idmatch = false;
        for (int cid=0; cid<sources.size(); cid++) {
          if ( sources.get(cid).id == i ) {
            idmatch = true;
            sources.get(cid).newtarget = sources.get(cid).getCentroid( nya.getMarkerVertex2D(i));
            sources.get(cid).markerSize = sources.get(cid).getMarkerSize(nya.getMarkerVertex2D(i));
            sources.get(cid).lastupdate = millis();
          }
        }

        if ( !idmatch ) {
          sources.add( new Mover(i, nya.getMarkerVertex2D(i)  ) ); //create new one
        }

        if (!interpolate) { //send coordinates of only properly detected markers!
          comm.send(i, sources.get(i).location ); //send marker ID + current location
        }
      }
    }

    //check collection of markers instances
    //if we are not detecking given marker for longer then x it means it has dissappeared
    ArrayList<Mover> updatedList = new ArrayList<Mover>();
    for (int cid=0; cid<sources.size(); cid++) {
      sources.get(cid).update();
      //send every marker id + location to remote including interpolated locations
      if (interpolate) {
        comm.send(cid, sources.get(cid).location );
      }
      if ( sources.get(cid).lastupdate > millis()-1000 ) {
        updatedList.add( sources.get(cid) );
      } else {
        println("marker "+sources.get(cid).id+" lost");
      }
    }
    sources = updatedList; //discard old and dead particles
    countFPS(); //keep track of performance
  }

  fill(255);
  text("press m to hide / show menu", 50, 50 );
  if (renderGUI) {
    cp5.draw();
  }
}


public void keyPressed() {
  switch(key) {
  case 'm':
    //turn on or off rendering of the GUI
    renderGUI = !renderGUI;
    break;
  }
}

//display current fps in the window title bar
void countFPS() {
  if (frameCount%30 == 0) {
    buf.insert(round(frameRate));
    surface.setTitle("Marker detection fps: " + round(frameRate) +
      " avg: " + buf.getAvg()+1 );
  }
}
