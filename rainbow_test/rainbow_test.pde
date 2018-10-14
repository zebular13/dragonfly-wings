OPC opc;

void setup()
{
  opc = new OPC(this, "127.0.0.1", 7890);
  frameRate(10);
  colorMode(RGB, 100);
}

void draw()
{

  for (int i = 0; i < 511; i++) {
    int r   = (i >> 16) & 0xFF;
    int g = (i >> 8) & 0xFF;
    int b  = (i) & 0xFF;
    float hue = (millis() * 0.01 + i * 2.0) % 100; 
    opc.setPixel(i, color(r, g, b));
  }

  // When you haven't assigned any LEDs to pixels, you have to explicitly
  // write them to the server. Otherwise, this happens automatically after draw().
  opc.writePixels();
}
