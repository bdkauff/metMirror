void metMirror() {
  if (camera.available() == true) {
    camera.read();
  }

  camera.loadPixels();

  background(0);

  for (int x=0;x<outXDim;x++) {
    for (int y=0;y<outYDim;y++) {

      int xPos = x*outWidth;
      int yPos = y*outHeight;
      int index = xPos+(yPos*width);

      color thisColor = camera.pixels[index];
      int matchIndex = findMatch(thisColor);

      float rx = (noise((frameCount*speed)+(index)+((float)index/camera.pixels.length))-.5)*rAmount;
      float ry = (noise((frameCount*speed)+(index)+((float)index/camera.pixels.length)+200)-.5)*rAmount;

      //image(faces[matchIndex], xPos+rx, yPos+ry, outWidth, outHeight);
    }
  }
  camera.updatePixels();
}

////////////////////////////////////////////
////////////////////////////////////////////
////////////////////////////////////////////

int findMatch(color c) {
  float r = red(c);
  float g = green(c);
  float b = blue(c);

  float smallest = 255*3;
  int winner = -1;

  for (int i=0;i<pics.length;i++) {
    float rDiff = abs(pics[i].avgRed-r);
    float gDiff = abs(pics[i].avgGreen-g);
    float bDiff = abs(pics[i].avgBlue-b);
    float total = rDiff+gDiff+bDiff;
    if (total<smallest) {
      winner = i;
      smallest = total;
    }
  }
  return winner;
}

////////////////////////////////////////////
////////////////////////////////////////////
////////////////////////////////////////////

void createFaces() {
  int counter = 0;

  master.loadPixels();

  for (int xStep=0;xStep<xDim;xStep++) {
    for (int yStep=0;yStep<yDim;yStep++) {
      if (counter<faces.length) {
        faces[counter] = createImage(master.width/xDim, master.height/yDim, ARGB);
        faces[counter].loadPixels();

        for (int xAdd=0;xAdd<=master.width/xDim;xAdd++) {
          for (int yAdd=0;yAdd<=master.height/yDim;yAdd++) {

            int x = xAdd+(xStep*(master.width/xDim));
            int y = yAdd+(yStep*(master.height/yDim));
            int mIndex = x + (y*master.width);
            int fIndex = xAdd + (yAdd*(master.width/xDim));

            if (fIndex<faces[counter].pixels.length && mIndex<master.pixels.length) {
              faces[counter].pixels[fIndex] = master.pixels[mIndex];
            }
          }
        }
        pics[counter] = new Pic(faces[counter]);
        counter++;
      }
    }
  }
  master.updatePixels();
}

////////////////////////////////////////////
////////////////////////////////////////////
////////////////////////////////////////////



