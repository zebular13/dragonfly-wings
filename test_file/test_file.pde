// Demonstration that pokes colors into the LEDs directly instead
// of mapping them to pixels on the screen. You may want to do this
// if you have your own mapping scheme that doesn't fit well with
// a 2D display.

OPC opc;

int flashIndex = 0;
int index = 0;
int max = 512;




void setup()
{
  opc = new OPC(this, "127.0.0.1", 7890);
  frameRate(5);
  colorMode(RGB, 100);
  
  for (int i = 0; i < max; i++) {
    opc.setPixel(i, color(0, 0, 0));
  }
  opc.writePixels();
}

void draw()
{
//  for (int i = 0; i < index; i++) {
//    opc.setPixel(i, color(255, 0, 0));
//  }
// 
  
  
  // RAINBOW FADE!!!!!
  for (int i = 64 * 0; i < 64 * 0 + 64; i++) {
    opc.setPixel(i, color(255, 0, 0));
  }
  for (int i = 64 * 1; i < 64 * 1 + 64; i++) {
    opc.setPixel(i, color(255, 255, 0));
  }
  for (int i = 64 * 2; i < 64 * 2 + 64; i++) {
    opc.setPixel(i, color(0, 255, 0));
  }
  for (int i = 64 * 3; i < 64 * 3 + 64; i++) {
    opc.setPixel(i, color(0, 255, 255));
  }
  for (int i = 64 * 4; i < 64 * 4 + 64; i++) {
    opc.setPixel(i, color(0, 0, 255));
  }
  for (int i = 64 * 5; i < 64 * 5 + 64; i++) {
    opc.setPixel(i, color(255, 0, 255));
  }
  for (int i = 64 * 6; i < 64 * 6 + 64; i++) {
    opc.setPixel(i, color(255, 255, 255));
  }
  for (int i = 64 * 7; i < 64 * 7 + 64; i++) {
    opc.setPixel(i, color(128, 0, 128));
  }
  
  for (int i = 0; i < 8; i++) {
    int flash = (index % 2) == 0 ? 0 : 255;
    color flashColor = color(flash, flash, flash);

    opc.setPixel(i * 64 + flashIndex, flashColor);
  }

  // When you haven't assigned any LEDs to pixels, you have to explicitly
  // write them to the servexxxzzzr. Otherwise, this happens automatically after draw().
  opc.writePixels();
  
  index++;
}

void keyPressed() {
  if (key == 'x') {
    flashIndex++;
  }
  if (key == 'z') {
    flashIndex--;
  }

  println("index is: " + flashIndex);
}

