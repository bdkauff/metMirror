class Pic {

  float avgRed, avgGreen, avgBlue;
  color avgC;

  Pic (PImage pic) {

    float counter = 0;
    float tRed = 0;
    float tGreen = 0;
    float tBlue = 0;
    pic.loadPixels();

    for (int i=0;i<pic.pixels.length;i++) {
      if (brightness(pic.pixels[i])>25 && brightness(pic.pixels[i])<255) {
        tRed += red(pic.pixels[i]);
        tGreen += green(pic.pixels[i]);
        tBlue += blue(pic.pixels[i]);
        counter++;
      }
    }
    pic.updatePixels();

    avgRed = tRed/counter;
    avgGreen = tGreen/counter;
    avgBlue = tBlue/counter;

    avgC = color(avgRed, avgGreen, avgBlue);
  }
}

