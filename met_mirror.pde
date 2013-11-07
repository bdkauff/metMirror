import processing.video.*;
public Capture camera;

//andy's filter stuff: 
int faceSize = 6;              //changes the resolution (# of faces drawn)
float speed = 0.03;            //changes how fast they wiggle
float rAmount = 26;            //changes how much they wiggle
int xDim = 23;
int yDim = 12;
PImage[] faces = new PImage[xDim*yDim];
PImage master;
Pic[] pics = new Pic[xDim*yDim];
int outWidth = faceSize*3;
int outHeight = faceSize*5;
int outXDim = 640/outWidth;
int outYDim = 480/outHeight;
boolean snap = false;


void setup() {
  size(640, 480,P2D);
  master = loadImage("mkHalf.png");
  createFaces();//for Andy's filter

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    camera = new Capture(this, cameras[0]);
    camera.start();
  }
}

void draw() {
  metMirror();
  set(0, 0, camera);
}

