ArrayList<Mover> sources = new ArrayList<Mover>();

class Mover {
  int id;
  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed;
  PVector[] corners;
  long lastupdate = 0;
  PVector newtarget; //last detected marker position
  color col;

  Mover(int currid, PVector[] currcorners) {
    id = currid;
    corners = currcorners;
    location = getCentroid(corners);
    newtarget = location;
    velocity = new PVector(0, 0);
    topspeed = 10;
    lastupdate = millis();
    col = color( int(random(0,255)), int(random(0,255)) , int(random(0,255)), 150 );
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

  void update() {  
    // Compute a vector that points from location to mouse
    //PVector mouse = newtarget; //new PVector(mouseX, mouseY);
    PVector acceleration = PVector.sub(newtarget, location);
    // Set magnitude of acceleration
    acceleration.setMag(1.2);
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);

    display();
  }

  void display() {
    //stroke(255,0,0);
    //strokeWeight(2);
    fill(col);
    ellipse(location.x, location.y, 48, 48);
  }
}
