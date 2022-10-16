import controlP5.*;
ControlP5 cp5;

float cameraBounds = 70;

float cameraX = 0;
float cameraY = 0;
float cameraZ = 15;

float offset = 0;
float translateOffset = 5;
float FOV = 60;

public void setup(){
  size(1000, 800, P3D);
  cp5 = new ControlP5(this);
  
  cp5.addSlider("cameraX", -cameraBounds, cameraBounds).setPosition(20, 30);
  cp5.addSlider("cameraY", -cameraBounds, cameraBounds).setPosition(20, 50);
  cp5.addSlider("cameraZ", -cameraBounds, cameraBounds).setPosition(20, 70);
  cp5.addSlider("offset", -1, 1).setPosition(20, 90);
  cp5.addSlider("translateOffset", 1, 10).setPosition(20, 110);
  cp5.addSlider("FOV", 1, 179).setPosition(20, 130);
}

 public void draw () {
  background(50);
  
  //2 matrices to set up:
  // 1. Projection matrix - uses the perspective() function -- often just called once
  // 2. Cmaera matrix -- uses the camera() function -- called every frame (typically)
  
  perspective(radians(FOV), (float)width/height, 0.1f, 100);
  
  if (keyPressed){
    if(key == 'w'){
      cameraZ -= 1;
    }
    if (key == 's'){
      cameraZ += 1;
    }
    if (key == 'a'){
      cameraX -= 1;
    }
    if (key == 'd'){
      cameraX += 1;
    }
  }
  
  
  // eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ
  camera(cameraX, cameraY, cameraZ, // Camera position
         cameraX, cameraY, cameraZ - 1, // Look-at position
         0, 1, 0);// World up axis
  fill(255);
  
  // Draw at the current transformation matrix location (default is the identity matrix, or 0, 0, 0 with no rot or scale)
  box(1.5f);
  
  // Create an "environment" to give a frame of reference
  for (int i = -10; i <= 10; i++){
    // Draw an X-axis
    int colorValue = (int)map(i, -10, 10, 0, 255);
    fill(colorValue, 0, 0);
    pushMatrix(); // Create a NEW matrix on the stack to be combined (multiplied) with the previous one
      translate(i, 0, 0);
      box(0.5f);
    popMatrix(); // Removes this matrix we just made and leaves the previous one untouched
    
    // Draw a Y-axis
    fill(0, colorValue, 0);
    pushMatrix();
      translate(0, i, 0);
      box(0.5f);
    popMatrix();
       
    //Draw a Z-axis
    fill(0, 0, colorValue);
    pushMatrix();
      translate(0, 0, i);
      box(0.5f);
    popMatrix();   
  }
  
  colorMode(HSB, 360, 100, 100);
  for(int i = 0; i < 360; i+= 12){
   pushMatrix();
     rotateY(radians(i));
     translate(translateOffset, offset * (i/4), 0);
     fill(i, 100, 100);
     box(0.5f);
   popMatrix();
    
  } 
  colorMode(RGB, 255);
  
  // Reset the perspective and camera matrices, so ControlP5 will render correctly
  perspective();
  camera();
  
}
