import controlP5.*;

ControlP5 cp5;


PVector position = new PVector(100, 100);
float speed = 5.0f;

PVector pos2Mouse;
PVector normalized;
PVector scaled;

MovingObject obj = new MovingObject (10, new PVector(0, 0));
ArrayList<MovingObject> objects = new ArrayList<MovingObject>();



void setup() {
  size(800, 800);
  cp5 = new ControlP5(this);
  cp5.addSlider("speed", 1.0, 50.0f);

  objects.add(new MovingObject(10, new PVector(0, 0)));
  objects.add(new MovingObject(1.0, new PVector(400, 400))); //slow object
  objects.add(new MovingObject(0.1, new PVector(800, 0))); //really slow obj
}


void draw() {
  background (200);
  //1. Calculate a vector from A to B (B - A )
  pos2Mouse = new PVector(mouseX - position.x, mouseY - position.y);

  //2. Normalize the vector
  normalized = new PVector(mouseX - position.x, mouseY - position.y);
  normalized.normalize(); // Set the magnitude to 1

  //3. Scale the vector based on some speed/rate scalar value
  scaled = new PVector(normalized.x, normalized.y);
  scaled.mult(speed);

  //circle moves on its own
  //Compare magnitude of the orig dir vector to the scaled version..
  //if the scaled version is larger than the orig... just move by the original
  if (pos2Mouse.mag() > scaled.mag()) {
    position.add(scaled);
  } else {
    //Move by the original vector, essentially "teleporting" to the goal
    position.add(pos2Mouse);
  }

//first example
//  circle (position.x, position.y, 50);

//  //Draw the normalized version of the vector
//  strokeWeight(30);
//  stroke(255, 0, 0);
//  strokeCap(SQUARE);
//  line(position.x, position.y, position.x + normalized.x, position.y + normalized.y);

//  strokeWeight(25);
//  stroke(255, 255, 0);
//  line(position.x, position.y, position.x + scaled.x, position.y + scaled.y);

//  if (pos2Mouse.mag() < scaled.mag()) {
//    strokeWeight(20);
//    stroke(255, 100, 0);
//    line(position.x, position.y, position.x + pos2Mouse.x, position.y + pos2Mouse.y);
//  }

//  strokeWeight(3);
//  stroke(0);
//  line(position.x, position.y, position.x + pos2Mouse.x, position.y + pos2Mouse.y);



  for (int i = 0; i < objects.size(); i++) {
    objects.get(i).Update(new PVector(mouseX, mouseY));
    objects.get(i).Draw();
  }
}


void keyPressed() {
  if (keyCode == UP)
    speed += 1.0f;
  else if (keyCode == DOWN)
    speed -= 1.0f;


  if (key == ' ') {

    //Compare magnitude of the orig dir vector to the scaled version..
    //if the scaled version is larger than the orig... just move by the original
    if (pos2Mouse.mag() > scaled.mag()) {
      position.add(scaled);
    } else {
      //Move by the original vector, essentially "teleporting" to the goal
      position.add(pos2Mouse);
    }
  }
}
