OPC opc;

int ledsPerStrip = 107;

int[] displayMemory = new int[ledsPerStrip * 6];
int[] drawingMemory = new int[ledsPerStrip * 6];



void setup() {
  opc = new OPC(this, "127.0.0.1", 7890);
  frameRate(5);
  random(2000);
  colorMode(RGB, 100);
  
  //for (int i = 0; i < max; i++) {
  //  opc.setPixel(i, color(0, 0, 0));
  //}
  opc.writePixels();
}

int frameTime = millis();
float background_hue = 189.0; //default to mid-blue

void draw() {
    // draw color changing background
    colorBackground();
}

void colorBackground() {
  float deltahue = ((float)((int)random(2000) - 1000)) * 0.003; // -2.0 to +2.0
  deltahue += (background_hue - background_hue) * 0.001; // bias towards 269.0
  //Serial.printf("deltahue = %.2f\n", deltahue);
  background_hue += deltahue;
  if (background_hue > 289.0) background_hue = 289.0; //don't get too red
  if (background_hue < 80.0) background_hue = 80.0; //don't get too yellow-green
  float hue = background_hue;
  //Serial.printf("hue = %d\n", hue);

  for (int i = 0; i < ledsPerStrip; i++) { //set color on wish 2
    float saturation = 100 + random(25);
    float lightness = 30 + random(10);
    opc.setPixel(i, makeColor(hue - (i * 0.6), saturation, lightness));
  }
  for (int i = ledsPerStrip; i < ledsPerStrip * 2; i++) { //set color on wish 2
    float saturation = 100 + random(25); 
    float lightness = 30 + random(10);
    opc.setPixel(i, makeColor(hue - ((i - ledsPerStrip) * 0.6), saturation, lightness));
  }
}
