import controlP5.*;
ControlP5 cp5;

PVector startPosition;
PVector endPosition;

Slider ratioSlider;
float ratio = 0.0f;
float rate = 0.0f;

boolean lerpin = false;

void setup() {
  size (800, 800);
  startPosition = new PVector(100, height/2);
  endPosition = new PVector (700, height/2);

  cp5 = new ControlP5(this);
  ratioSlider = cp5.addSlider("ratio", 0.0f, 1.5f)
    .setSize(200, 50)
    ;

  cp5.addSlider("rate", 0.0f, 0.5f)
    .setSize(200, 50)
    .setPosition(20, 100)
    ;

  cp5.addButton("Start")
    .setPosition(20, 160)
    ;
}

void draw() {
  background (100);

  //Modify our ratio based on time
  if (lerpin) {
    ratio += rate;
    if (ratio > 1.0f) {
      ratio = 1.0f; //Make sure we stop right at the end and don't overshoot
      lerpin = false;
    }
    ratioSlider.setValue(ratio);
  }

  PVector currentPosition = new PVector();
  currentPosition.x = lerp(startPosition.x, endPosition.x, ratio);
  currentPosition.y = lerp(startPosition.y, endPosition.y, ratio);

  //Draw start and end
  fill(255, 0, 0);
  circle(startPosition.x, startPosition.y, 20);
  circle(endPosition.x, endPosition.y, 20);

  fill(255);
  float size = lerp(10, 100, ratio);
  circle(currentPosition.x, currentPosition.y, size);
}

void mouseClicked() {
  if (cp5.isMouseOver()) {
    return;
  }
  endPosition.x = mouseX;
  endPosition.y = mouseY;
}


void Start () {
  lerpin = true;
  ratio = 0; //start from the beginning
}
