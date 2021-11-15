import controlP5.*;
import processing.video.*;
import jp.nyatla.nyar4psg.*;
import oscP5.*;
import netP5.*;
import java.util.*;
import processing.video.*;


public class GUI {
  ControlP5 cp5;
  JSONObject json;
  String pathToSavedOptions = "data/options.json";
  String userIP;
  String loadedCamera;
  int camIndex;
  Integer listeningPort;
  String cameras[];
  boolean isShown;

  public GUI(ControlP5 cp5) {
    this.cp5 = cp5;
    this.isShown = false;
    loadJSON();
  }

  public void initGUI() {
    cp5.addTextfield("IPText")
      .setPosition(50, 400)
      .setSize(200, 20)
      .setText(userIP)
      .setLabel("Insert IP address of destination")
      .setVisible(false);
    cp5.addTextfield("Port")
      .setPosition(50, 360)
      .setSize(200, 20)
      .setText(listeningPort.toString())
      .setLabel("The listening port")
      .setVisible(false);
    cp5.addScrollableList("Camera List")
      .setPosition(50, 100)
      .setSize(200, 100)
      .setBarHeight(20)
      .setItemHeight(20)
      .setValue(camIndex)
      .setVisible(false);
      if(cameras != null){
        cp5.get(ScrollableList.class, "Camera List").setItems(cameras);
      }
  }

  public void showGUI(){
    println("REVEALING");
    gui.isShown = true;
    cp5.get(Textfield.class, "IPText").setVisible(true);
    cp5.get(Textfield.class, "Port").setVisible(true);
    cp5.get(ScrollableList.class, "Camera List").setVisible(true);
  }

  public void hideGUI(){
    println("DISSOLVING");
    this.isShown = false;
    cp5.get(Textfield.class, "IPText").setVisible(false);
    cp5.get(Textfield.class, "Port").setVisible(false);
    cp5.get(ScrollableList.class, "Camera List").setVisible(false);
  }



  public String[] checkCameraList() {

    cameraTimeout();
    cameras = Capture.list();
    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      cameras = null;
    } else {
      println("Available cameras:");
      printArray(cameras);
    }
    return cameras;
  }

  public void cameraUpdate(){
    println("UPDATING CAMERAS");
    cameras = checkCameraList();
    if(cameras != null){
        cp5.get(ScrollableList.class, "Camera List").setItems(cameras);
      }else{
        cp5.get(ScrollableList.class, "Camera List").clear();
      }
  }

  public void cameraTimeout() {
    //Waiting 10 seconds for camera list init
    long timeBeforeCameraWaiting = second();
    long t = second();
    println("waiting for cameras");
    while ( Capture.list().length == 0 ) {
      if (second() - t > 0) {
        t= second();
        print(". ");
      }
      if (second() - timeBeforeCameraWaiting > 1) //wait 5 secs
      {
        break;
      }
    }
    println();
  }

  public void saveJSON(String[] cameras) {
    try {
      json.setString("cameraName", cameras[camIndex]);
    }
    catch(NullPointerException e) {
      json.setString("cameraName", "");
    }
    json.setInt("index", camIndex);
    //userIP = cp5.get(Textfield.class, "IPText").getText();
    json.setString("ip", userIP);
    json.setInt("port", listeningPort);
    saveJSONObject(json, pathToSavedOptions);
  }

  public void loadJSON() {
    try {
      this.json = loadJSONObject(pathToSavedOptions);
      this.userIP = json.getString("ip");
      this.loadedCamera = json.getString("cameraName");
      this.camIndex = json.getInt("index");
      this.listeningPort = json.getInt("port");
    } 
    catch(NullPointerException e) {
      this.json = new JSONObject();
      this.userIP = "127.0.0.1";
      this.loadedCamera = "";
      this.camIndex = 0;
      this.listeningPort = 12000;
    }
  }
  
    public void cameraList(int n) {
    println("User has chosen camera: " + cameras[n]);
    CColor c = new CColor();
    c.setBackground(color(255, 0, 0));
    cp5.get(ScrollableList.class, "cameraList").getItem(n).put("color", c);
  }

  public String getUserIP() {
    return userIP;
  }
  public int getListeningPort() {
    return listeningPort;
  }

  public String getLoadedCamera() {
    return loadedCamera;
  }

  public int getIndex() {
    return camIndex;
  }
  
  public String [] getCameras(){
   return cameras;
  }

  public void setUserIP(String newIP) {
    println("User entered IP: " + newIP);
    userIP = newIP;
    saveJSON(this.cameras);
  }
  
  public void setListeningPort(String newPort){
      println("User entered port: " + newPort);
      listeningPort = Integer.parseInt(newPort);
      saveJSON(this.cameras);
  }

  public void setLoadedCamera(String cam) {
    loadedCamera = cam;
  }
  
  public void setCameras(String [] c){
   cameras = c;
  }
}