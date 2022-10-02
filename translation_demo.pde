import controlP5.*;
ControlP5 cp5;
float lineDistance = 200;
float angle = 45;

void setup() {
  size(800, 800, P2D);
  cp5 = new ControlP5(this);
  cp5.addSlider("lineDistance", 50, 200)
    .setPosition(200, 50)
    ;
}

void draw() {
  background(200);
  fill(255, 0, 0);
  circle(0, 0, 100); // (0, 0) FROM the current transform location

  pushMatrix();
    //Translate to the center of the screen
    translate(width/2, height/2);
    circle(0, 0, 100); // (0, 0) FROM the current transform location (which is width/2, height/2)
  
    strokeWeight(25);
    rotate(radians(angle));
    stroke(255);
    line(0, 0, lineDistance, 0);
    strokeWeight(1);
    stroke(0);
  
    // Draw something at then end of the line
    translate(lineDistance, 0);
    rectMode(CENTER);
  
    pushMatrix();
      rotate(angle/2);
      fill(255);
      square(0, 0, 40);
    
      strokeWeight(8);
      stroke(255, 0, 0);
      line(0, 0, 50, 0); // X-axis line
    
      stroke(0, 255, 0);
      line(0, 0, 0, 50); // Y-axis line
      strokeWeight(1);
      stroke(0);
  
    popMatrix();
  popMatrix();

  // Draw a line rotated 45* around the center of the circle
  float x = cos(radians(45)) * lineDistance;
  float y = sin(radians(45)) * lineDistance;
  strokeWeight(10);
  line(width/2, height/2, width/2 + x, height/2 +y);

  strokeWeight(1);
  fill(255, 255, 0);
  circle(width/2, height/2, 60);

  angle += 0.1f;
}
