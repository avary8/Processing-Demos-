import controlP5.*;
ControlP5 cp5;
ArrayList<PGraphics> layers = new ArrayList<PGraphics>();
boolean onFirstLayer = true;

int currentLayerIndex = 0;

int bubbleCount = 10;
int xMin = -10;
int xMax = 10;
int yMin = -10;
int yMax = 10;
int radiusBase = 20;
int radiusMin = -10;
int radiusMax = 10;


void setup() {
  size(1000, 800, P2D);
  cp5 = new ControlP5(this);
  cp5.addButton("ToggleLayer");

  cp5.addSlider("bubbleCount", 3, 20).setPosition(200, 30);
  cp5.addSlider("xMin", -50, 50).setPosition(200, 50);
  cp5.addSlider("xMax", -50, 50).setPosition(200, 70);
  cp5.addSlider("yMin", -50, 50).setPosition(200, 90);
  cp5.addSlider("yMax", -50, 50).setPosition(200, 110);
  cp5.addSlider("radiusBase", 10, 50).setPosition(200, 130);
  cp5.addSlider("radiusMin", -50, 50).setPosition(200, 150);
  cp5.addSlider("radiusMax", -50, 50).setPosition(200, 170);

  //create a layer with the same size as the window
  //layerOne = createGraphics(1000, 800, P2D);

  //create a layer smaller than the window
  //layerTwo = createGraphics(400, 300, P2D);

  //adding pgraphics layers to arraylist layers
  layers.add(createGraphics(1000, 800, P2D));
  layers.add(createGraphics(1000, 300, P2D));
}

void draw() {
  layers.get(0).beginDraw();
  layers.get(0).circle(500, 100, 75);
  layers.get(0).endDraw();

  layers.get(1).fill(color(255, 0, 0));

  layers.get(1).beginDraw();
  layers.get(1).rect(0, 0, 80, 102);
  layers.get(1).endDraw();

  //clear background for the entire screen
  background(200);

  // Draw all layers as images, one at a time (first drawn is on the bottom)
  for (int i = 0; i < layers.size(); i++) {
    image(layers.get(i), 0, 0);
  }
}


void ToggleLayer() {
  //wrap our index around so we dont go out of bounds of our array
  if (currentLayerIndex >= layers.size())
    currentLayerIndex = 0;
}

//Call this when the button is held and the mouse is moved
void mousePressed(){
  mouseDragged();
}

//Call this when the button is held and the mouse is moved
void mouseDragged() {
  if (cp5.isMouseOver())
    return;

  layers.get(currentLayerIndex).beginDraw();
  layers.get(currentLayerIndex).noStroke();
  //draw several circles in a bubbly sort of brush
  for (int i = 0; i < bubbleCount; i++) {
    layers.get(currentLayerIndex).circle(mouseX + (int)random(xMin, xMax), mouseY + (int)random(yMin, yMax), radiusBase + (int)random(radiusMin, radiusMax));
  }
  
  layers.get(currentLayerIndex).endDraw();
}
