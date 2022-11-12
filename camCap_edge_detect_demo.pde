import processing.video.*;
import controlP5.*;
ControlP5 cp5;
Capture cam;

float[][] kernel = {{ -1, -1, -1},
  { -1, 8, -1},
  {-1, -1, -1}};
  
float[][] kernel2 = {{ 0, -1, 0},
  { -1, 4, -1},
  {0, -1, 0}};
  
float startingIntensity = 128;
int value = 2;
void setup() {
  size(1280, 960);
  
  String[] cameras = Capture.list();
  
  if(cameras.length == 0){
    println("There are no cameras available for capture");
    exit();
  }
  else {
    println("Available cameras: ");
    for(int i = 0; i < cameras.length; i++){
      println(cameras[i]);
      }
      //The camera can be init directly using an
      //element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
    cp5 = new ControlP5(this);
    cp5.addSlider("startingIntensity", 0, 255.0f);
    cp5.addSlider("value", 1, 50)
      .setPosition(20,50);
}

void draw(){
  if (cam.available() == true){
    cam.read();
  }
  
  image(cam, 0, 0); //Draw a capture image from the camera
    PImage copy = cam.copy();

  copy.filter(INVERT);
  //image(copy, width/2, 0);

  ExampleOne(cam, width/2, 0);
  ExampleTwo(cam, 0, height/2);
  ExampleThree(cam, width/2, height/2);
  textSize(30);
  text("Original", 0, height/2-30);
  text("Edge detection", width/2, height/2-30);
  text("Blur before edge detection", 0, height-30);
  text("Different kernel", width/2, height-30);
}

void ExampleOne(Capture src, int xPos, int yPos){
  PImage grayImg = cam.copy();
  grayImg.filter(GRAY);
  //grayImg.filter(BLUR);

  // Create an opaque image of the same size as the original
  PImage edgeImg = createImage(grayImg.width, grayImg.height, RGB);

  // Loop through every pixel in the image
  for (int y = 1; y < grayImg.height-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < grayImg.width-1; x++) {  // Skip left and right edges
      // Output of this filter is shown as offset from 50% gray.
      // This preserves transitions from low (dark) to high (light) value.
      // Starting from zero will show only high edges on black instead.
      float sum = startingIntensity;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*grayImg.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = blue(grayImg.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the output value
      // based on the sum from the kernel
      edgeImg.pixels[y*edgeImg.width + x] = color(sum);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  edgeImg.updatePixels();

  image(edgeImg, xPos, yPos); // Draw the new image
  //blend(edgeImg, xPos, yPos, 640, 480, 0, 0, 640, 480, MULTIPLY);
}


void ExampleTwo(Capture src, int xPos, int yPos){

  PImage grayImg = cam.copy();
  //grayImg.filter(GRAY);
  grayImg.filter(BLUR);
  // Create an opaque image of the same size as the original
  PImage edgeImg = createImage(grayImg.width, grayImg.height, RGB);
  // Loop through every pixel in the image
  for (int y = 1; y < grayImg.height-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < grayImg.width-1; x++) {  // Skip left and right edges
      // Output of this filter is shown as offset from 50% gray.
      // This preserves transitions from low (dark) to high (light) value.
      // Starting from zero will show only high edges on black instead.
      float sum = startingIntensity;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*grayImg.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = blue(grayImg.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the output value
      // based on the sum from the kernel
      edgeImg.pixels[y*edgeImg.width + x] = color(sum);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  edgeImg.updatePixels();
  image(edgeImg, xPos, yPos); // Draw the new image
}

void ExampleThree(Capture src, int xPos, int yPos){
  PImage grayImg = cam.copy();
  grayImg.filter(GRAY);
  grayImg.filter(BLUR);
  // Create an opaque image of the same size as the original
  PImage edgeImg = createImage(grayImg.width, grayImg.height, RGB);
  // Loop through every pixel in the image
  for (int y = 1; y < grayImg.height-1; y++) {   // Skip top and bottom edges
    for (int x = 1; x < grayImg.width-1; x++) {  // Skip left and right edges
      // Output of this filter is shown as offset from 50% gray.
      // This preserves transitions from low (dark) to high (light) value.
      // Starting from zero will show only high edges on black instead.
      float sum = startingIntensity;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*grayImg.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = blue(grayImg.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          sum += kernel2[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the output value
      // based on the sum from the kernel
      edgeImg.pixels[y*edgeImg.width + x] = color(sum);
    }
  }
  // State that there are changes to edgeImg.pixels[]
  edgeImg.updatePixels();
  image(edgeImg, xPos, yPos); // Draw the new image
}
