import processing.video.*;


//andy's filter stuff: 
int faceSize = 7;              //changes the resolution (# of faces drawn)
float speed = 0.03;            //changes how fast they wiggle
float rAmount = 16;            //changes how much they wiggle
int xDim = 23;
int yDim = 12;
PImage[] faces = new PImage[xDim*yDim];
PImage master;
Pic[] pics = new Pic[xDim*yDim];
int outWidth = faceSize*3;
int outHeight = faceSize*5;
int outXDim = 1280/outWidth;
int outYDim = 960/outHeight;
boolean snap = false;

Capture video;

void setup() {
  size(1280, 960);
  frameRate(30);
  master = loadImage("./data/output_small_2.jpg");
  createFaces();

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available videos:");
    for (int i = 0; i < cameras.length; i++) {
      println(i+":    "+ cameras[i]);
    }


    video = new Capture(this, width, height);
    video.start();

    background(0);
  }
}

void draw() {

  if (video.available()) {
    video.read();
    video.loadPixels();


    for (int x=0;x<outXDim;x++) {
      for (int y=0;y<outYDim;y++) {

        int xPos = x*outWidth;
        int yPos = y*outHeight;
        int index = xPos+(yPos*width);

        color thisColor = video.pixels[index];
        int matchIndex = findMatch(thisColor);

        float rx = (noise((frameCount*speed)+(index)+((float)index/video.pixels.length))-.5)*rAmount;
        float ry = (noise((frameCount*speed)+(index)+((float)index/video.pixels.length)+200)-.5)*rAmount;

        //pixels[index] = thisColor;
        image(faces[matchIndex], xPos+rx, yPos+ry, outWidth, outHeight);
      }
    }


    updatePixels();
  }
}

