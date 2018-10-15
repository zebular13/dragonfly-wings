//based on Adafruit's strandtest arduino sketch. 
//adapted for processing by Monica Houston

OPC opc;
//Change this to how many LEDs you have
int numPixels = 899;

void setup()
{
  opc = new OPC(this, "127.0.0.1", 7890);
  frameRate(20);
  colorMode(RGB, 50, 50, 50);
}

void draw()
{
  rainbow(10); //the first one doesn't run the second time through??
  rainbowCycle(50);
  theaterChase(color(127, 127, 127), 100);
  colorWipe(color(0, 255, 255), 10); //cyan
  colorWipe(color(255, 255, 0), 20); //yellow
  colorWipe(color(0, 255, 0), 10); //green
  colorWipe(color(127, 0, 127), 10); //
}


void colorWipe(int c, int wait) {
  for(int i=0; i<numPixels; i++) {
    opc.setPixel(i, c);
    opc.writePixels();
    delay(wait);
  }
}

void rainbow(int wait) {
  int i, j;

  for(j=0; j<256; j++) {
    for(i=0; i<numPixels; i++) {
      opc.setPixel(i, Wheel((i+j) & 255));
    }
    opc.writePixels();
    delay(50);
  }
}

void rainbowCycle(int wait) {
    int i, j;

  for(j=0; j<256*5; j++) { // 5 cycles of all colors on wheel
    for(i=0; i< numPixels; i++) {
      opc.setPixel(i, Wheel(((i * 256 / numPixels + j)) & 255));
    }
    // When you haven't assigned any LEDs to pixels, you have to explicitly
  // write them to the server. Otherwise, this happens automatically after draw().
    opc.writePixels();
    delay(wait);
  }
}

void theaterChaseRainbow(int wait) {
  for (int j=0; j < 256; j++) {     // cycle all 256 colors in the wheel
      for (int q=0; q < 3; q++) {
        for (int i=0; i < 511; i=i+3) {
          opc.setPixel(i+q, Wheel( (i+j) % 255));    //turn every third pixel on
        }
        opc.writePixels();
        delay(wait);
  
        for (int i=0; i < 899; i=i+3) {
          opc.setPixel(i+q, 100);        //turn every third pixel off
        }
      }
    }
}

void theaterChase(int c, int wait) {
  for (int j=0; j<10; j++) {  //do 10 cycles of chasing
    for (int q=0; q < 3; q++) {
      for (int i=0; i < numPixels; i=i+3) {
        opc.setPixel(i+q, c);    //turn every third pixel on
      }
      opc.writePixels();

      delay(wait);

      for (int i=0; i < numPixels; i=i+3) {
        opc.setPixel(i+q, 0);        //turn every third pixel off
      }
    }
  }
}


// Input a value 0 to 255 to get a color value.
// The colours are a transition r - g - b - back to r.
int Wheel(int WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
    return color(255 - WheelPos * 3, 0, WheelPos * 3);
  }
  if(WheelPos < 170) {
    WheelPos -= 85;
    return color(0, WheelPos * 3, 255 - WheelPos * 3);
  }
  WheelPos -= 170;
  return color(WheelPos * 3, 255 - WheelPos * 3, 0);
}
