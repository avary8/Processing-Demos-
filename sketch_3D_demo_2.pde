import controlP5.*;
ControlP5 cp5;

float camBounds = 100;

float cameraX = 0;
float cameraY = 0;
float cameraZ = 15;

float offset = 0;
//float translateOffset = 5;
//float FOV = 60;
int pointCount = 10;

Triangle t = new Triangle();

void setup() {
  size(1200, 800, P3D);
  cp5 = new ControlP5(this);

  cp5.addSlider("cameraX", -camBounds, camBounds).setPosition(20, 30);
  cp5.addSlider("cameraY", -camBounds, camBounds).setPosition(20, 50);
  cp5.addSlider("cameraZ", -camBounds, camBounds).setPosition(20, 70);
  cp5.addSlider("offset", -1, 1).setPosition(20, 90);
  //cp5.addSlider("translateOffset", 1, 10).setPosition(20, 110);
  //cp5.addSlider("FOV", 1, 179).setPosition(20, 130);
  cp5.addSlider("pointCount", 3, 60).setPosition(20, 110);
  
  t.SetPoint(0, 2, 0, 0);
  t.SetPoint(1, -2, 0, 0);
  t.SetPoint(2, 0, -2, 0);
}

class Triangle {
  PVector[] points = new PVector[3];
  
  Triangle(){
    points = new PVector[3];
    for (int i = 0; i < 3; i++){
      points[i] = new PVector();
    }
  }
  
  void SetPoint(int index, float x, float y, float z){
    points[index].set(x, y, z);
  }
  
  void Draw(){
    beginShape(TRIANGLE);
    for (int i = 0; i < 3; i++){
      vertex(points[i].x, points[i].y, points[i].z);
      endShape(CLOSE);
    }
  }
}

class Quad {
  Triangle[] triangles = new Triangle[2];
}

class Mesh {
  ArrayList<Triangle> triangles; 
}

class Model {
  ArrayList<Mesh> meshes; 
}


class Scene {
  ArrayList<Model> models;
}


void draw () {
  FrameOfReference();

  fill(255);
  
  //t.Draw(); //draws triangle
  
  strokeWeight(1);
  stroke(0);
  
  beginShape();
  
  float degrees = 360 / pointCount;
  float angle = 0;
  for(int i = 0; i < pointCount; i++){
    float x = cos(radians(angle)) * 2;
    float y = sin(radians(angle)) * 2;
    vertex(x, y, 0); 
    
    angle += degrees;
  }
  
  endShape();
  
  noStroke();
  fill(255, 0, 255);
  DrawBox(0.1, 2, 0, 0);
  DrawBox(0.1, -2, 0, 0);
  DrawBox(0.1, 2, -2, 0);

  camera();
  perspective();
}


void DrawBox(float size, float x, float y, float z) {
  pushMatrix();
  translate(2, 0, 0);
  box(size);
  popMatrix();
  
}

  void FrameOfReference() {
    strokeWeight(2);
    background(50);
    perspective(radians(50.0f), (float)width/height, 0.1, 100);

    camera(cameraX, cameraY, cameraZ, 0, 0, 0, 0, 1, 0);
    for(int i = -10; i <= 10; i++){
      if(i >= -2 && i <= 2){
        continue;
      }
      int colorVal = (int)map(i, -10, 10, 0, 255);
      fill(colorVal, 0, 0);
      pushMatrix();
        translate(i, 0, 0);
        box(0.5);       
      popMatrix();
        
        
      // Draw a Y-axis
      fill(0, colorVal, 0);
      pushMatrix();
        translate(0, i, 0);
        box(0.5f);
      popMatrix();
       
      //Draw a Z-axis
      fill(0, 0, colorVal);
      pushMatrix();
        translate(0, 0, i);
        box(0.5f);
      popMatrix();    
    }
  }
