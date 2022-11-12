PImage source;

PImage a, b, c;
int amt = 20; // 20 == arbitrary value set for the "closeness" a color has to be to match the original

void setup()
{
  size(1000, 800, P2D);
  pixelDensity(displayDensity());
  // 1. Load an image
  source = loadImage("data/squirrel.jpg");  
  
  // 2. Get pixel colors
  
  // 3. Do some analysis of those colors
  //noLoop();
  a = source.get();
  b = source.get();
  c = source.get();
  a.loadPixels();
  b.loadPixels();
  c.loadPixels();
  source.loadPixels();
}

void draw()
{
  background(255);
  
  // Draw the source image
  image(source, 0, 0);
  //PImage img2;
   
  // Scale the color channels to create a modified copy of the original
  SetImageChannels(a, .3, 1, .3); // 30% red and blue
  SetImageChannels(b, .7, 1, .3); // 70% red, 30% blue
  
  color val = source.get(mouseX, mouseY); // Get a color from the original
  //println(val);
  
  for (int i = 0; i < source.width; i++)
  {
    for (int j = 0; j < source.height; j++)
    {
      int loc = i + j * c.width;
      color orig = source.pixels[loc];
      
      int r = (int)red(orig);
      int b = (int)blue(orig);
      int g = (int)green(orig);
      
      int r_v = (int)red(val);
      int b_v = (int)blue(val);
      int g_v = (int)green(val);
      
      // Check to see if every color channel is close to each of the sampled color's channel
      if (abs(r - r_v) < amt && abs(g - g_v) < amt && abs(b - b_v) < amt)
        c.pixels[loc] = color(255, 255, 255);
      else
        c.pixels[loc] = color(0, 0, 0);
    }
  }
  c.updatePixels();
  //SetImageChannels(c, .0, 1, .6);
  //for (int i = 0; i < a.pixels.length; i++)
  //  a.pixels[i] = color(red(a.pixels[i]), 0, blue(a.pixels[i]));
  
  //for (int i = 0; i < b.pixels.length; i++)
  //  b.pixels[i] = color(0, green(b.pixels[i]), blue(b.pixels[i]));

  //  int startX = width/2 + c.width/2;
  //  int startY = height/2 + c.height/2;
  //c = source.get();
  //for (int i = 0; i < c.width; i++)
  //{
  //  for (int j = 0; j < c.height; j++)
  //  {
  //    int loc = i + j * c.width;
      
  //    float r = red(c.pixels[loc]);
  //    float g = green(c.pixels[loc]);
  //    float b = blue(c.pixels[loc]);
      
  //    // Flip red and blue channels, amplify blue by 30%
  //    c.pixels[loc] = color(b*1.3, g, r);//color(red(c.pixels[loc]) * dist, green(c.pixels[loc]) * dist, blue(c.pixels[loc]) * dist);
  //  }
  //}
  //c.updatePixels();
  image(a, width/2, 0);
  image(b, 0, height/2);
  image(c, width/2, height/2);
 
  textSize(30);
  fill(0);
  text("Pixel Sample: " + red(val) + ", " + green(val) + ", " + blue(val), 0, height/2 - 30);
  text("Color match distance: " + amt, 0, height/2);
}

// Modify color channels by passed-in percentages
void SetImageChannels(PImage img, float r, float g, float b)
{
  for (int i = 0; i < img.pixels.length; i++)
    img.pixels[i] = color(red(img.pixels[i]) * r, green(img.pixels[i]) * g, blue(img.pixels[i]) * b);
}

void keyPressed()
{
  if (keyCode == UP)
    amt += 1;
  else if (keyCode == DOWN)
    amt -= 1;
  println("amt: " + amt);
}
