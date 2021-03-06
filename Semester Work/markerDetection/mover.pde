//tracked movement interpolation
ArrayList<Mover> sources = new ArrayList<Mover>();

class Mover {
  int id;
  // The Mover tracks location, velocity, and acceleration
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed;
  int delay;
  float markerSize;
  PVector[] corners;
  long lastupdate = 0;
  int jumpOffset = 3;
  PVector newtarget; //last detected marker position
  color col;

  Mover(int currid, PVector[] currcorners) {
    id = currid;
    corners = currcorners;
    location = getCentroid(corners);
    newtarget = location;
    velocity = new PVector(0, 0);
    topspeed = maxspeed;
    delay = delayG;
    //println("delay is: " + delay);
    //println("max speed is: " + topspeed);
    lastupdate = millis();
    col = color( int(random(0, 255)), int(random(0, 255)), int(random(0, 255)), 150 );
  }

  PVector getCentroid(PVector[] vec)
  {
    float x = 0;
    float y = 0;
    for (int i = 0; i < 4; i++) {
      x+=vec[i].x;
      y+=vec[i].y;
    }
    PVector res = new PVector(x*0.25, y*0.25, 0);
    //ellipse(res.x, res.y, 10, 10);
    return res;
  }

  float getMarkerSize(PVector[] cors) {
    float sum = 0;
    sum = cors[0].dist(cors[1]);
    //println("distance: " + sum);
    return sum;
  }

  void update() {
    PVector acceleration = PVector.sub(newtarget, location);
    PVector normNewTarget = new PVector(newtarget.x/cam.height, newtarget.y/cam.width);
    PVector normLocation = new PVector(location.x/cam.height, location.y/cam.width);
    float normDist = normNewTarget.dist(normLocation);
    fill(color(255, 0, 0));
    ellipse(newtarget.x, newtarget.y, 30, 30);

    if (newtarget.dist(location) < jumpOffset) {
      location = newtarget;
      display();
      return;
    }else{
      //prodlouzi vektor
       acceleration.setMag(1 + 2*(normDist*10));
    }
    if(topspeed < 1){
     topspeed = 1; 
    }
    //Velocity changes according to acceleration
    //velocity.add(acceleration);
    velocity = acceleration;
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
    display(); //render to screen visualized interpolated position
  }

  void display() {
    if (interpolate) { //in case interpolation is ON
      fill(col);
      ellipse(location.x, location.y, 48, 48);
    }
  }
}
