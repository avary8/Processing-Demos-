import controlP5.*;
ControlP5 cp5;
PImage img;
PImage img2;
PImage img3;

int circleSize = 3;
boolean done = false;
void setup()
{
  size(1000, 800, P2D);
  pixelDensity(2);
  img = loadImage("unicorn.jpg");
  img2 = loadImage("mask1.jpg");
  img3 = loadImage("mask2.jpg");

  noStroke();
  background(0);
  
  cp5 = new ControlP5(this);
  cp5.addSlider("circleSize", 1, 20);
  cp5.addButton("Reset").setPosition(20, 50);
}

void draw()
{
  ExampleOne();
  //ExampleTwo();
  //ExampleThree();
}

void ExampleOne()
{
  if (!done)
  {
    for (int i = 0; i < 100; i++)
    {
      int ranX = (int)random(img.width);
      int ranY = (int)random(img.height);
  
      color sampleFromOriginal = img.get(ranX, ranY);
  
      fill(sampleFromOriginal);
      float originalBrightness = brightness(sampleFromOriginal);
      float ratio = originalBrightness / 255.0f; // 0 - 1 range
      
      int coinToss = (int)random(0, 2);
      if (coinToss == 0)
        circle(ranX, ranY, circleSize * ratio);
      else
        square(ranX, ranY, circleSize * ratio);
    }
  }
}

void ExampleTwo()
{
  PImage finalImage = createImage(img.width, img.height, RGB);

  for (int y = 0; y < img.height; y++) // For every row in the image
  {
    for (int x = 0; x < img.width; x++)  // For every column in the row
    {
      color maskSample = img2.get(x, y);

      int brightness = (int)brightness(maskSample);

      if (mousePressed)
      {
        if (brightness < 10)
          finalImage.set(x, y, color(0));
        else
          finalImage.set(x, y, img.get(x, y));
      } else
      {
        if (brightness > 10)
          finalImage.set(x, y, color(0));
        else
          finalImage.set(x, y, img.get(x, y));
      }
    }
  }

  finalImage.updatePixels();

  image(finalImage, 0, 0);
}

void ExampleThree()
{
  for (int i = 0; i < 100; i++)
  {
    int ranX = (int)random(img.width);
    int ranY = (int)random(img.height);

    color sampleFromOriginal = img.get(ranX, ranY);
    color maskSample = img2.get(ranX, ranY);

    int brightness = (int)brightness(maskSample);

    if (brightness == 0) // Black color sample? Don't do anything else
      continue;

    fill(sampleFromOriginal);
    
    circle(ranX, ranY, circleSize);
  }
  if (keyPressed)
  background(0);
}



void keyPressed()
{
  if (keyCode == UP)    circleSize++;
  if (keyCode == DOWN)  circleSize--;
  if (key == ' ')       done = !done;
  println("circleSize: " + circleSize);
}

void Reset()
{
  background(0);
}
