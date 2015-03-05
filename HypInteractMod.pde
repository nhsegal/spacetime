/*
Description:
 This program makes an interactive Minkowski diagram.
 Position of Mouse - worldline of object with constant v.
 Left-click - toggle grid
 Right-click - toggle worldline
 Equitemps shown in red
 Equiptemps incorrect
 
 */
int counter = 0;

boolean gridOn = true;
boolean hypOn = true;
boolean lineOn = false;

color hypcolor = (150);
color gridcolor = (150); 
float hypThick = 1;
float gridThick = 1;
float equiTempThick = 1;
int div = 12;   //higher = closer together       
float x, y, x2, y2; // for tracing the hyperbolas

void setup() {
  size(700, 700);
  background(255);
  ellipseMode(CENTER);
}

void draw() {
  background(255);
  scale(1, -1);
  translate(width/2, -7*height/8);
  if (gridOn == true) {
    gridDraw();
  }

  if (hypOn == true) {
    hypDraw();
  }
  else {
    rotate(PI);
  }


  if (lineOn == true) {

    //Draw worldline
    stroke(0);
    float speed = -((float)mouseX - (float)(width)/2)/((float)mouseY - 7*(float)height/8);
    line (0, 0, -(mouseX - width/2)*2, (mouseY - 7*height/8)*2);
    float gamma = 1/sqrt(1-speed*speed);
    for (int i = 0; i< 10; i++) {
      fill(10, 10, 10);
      stroke(10, 10, 10);
      ellipse(-speed*gamma*(width)*i/div, -(width)*gamma*i/div, 5, 5);
      stroke(245, 0, 0);
      strokeWeight(equiTempThick);
      // line (-width, (5-width)*gamma*i/div, width, (5-width)*gamma*i/div);
      //line ( x, y, x2, y2) where x,y is the ellipse and x2 = x + width/2, y2 = y + width/2 * 1/speed

      line (-speed*gamma*(width)*i/div + width/(speed), -(width)*gamma*i/div + width, -speed*gamma*(width)*i/div - width/(speed), -(width)*gamma*i/div -width);
    }
  }
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    counter = counter + 1;
    if (counter == 2) {
      counter = 0;
    }
    if (counter == 0) {
      hypOn = !hypOn;
    }
    if (counter == 1) { 
      gridOn = !gridOn;
    }
  }
  if (mouseButton == RIGHT) {
    lineOn = !lineOn;
  }
}

void gridDraw() { 
  stroke(gridcolor);
  strokeWeight(gridThick);
  for (int i = 0; i < width; i=i+width/div) {
    line(-width/2, i, width/2, i);
  }
  for (int i = 0; i > -width/2; i=i-width/div) {
    line(-width/2, i, width/2, i);
  }
 /* for (int i = 0; i < height/2; i=i+height/div) {
    line(i, -height/2, i, height);
  }
  for (int i = 0; i > -height/2; i=i-height/div) {
    line(i, -height/2, i, height);
  }
  */
}

void hypDraw() {
  smooth();  
  stroke(hypcolor);
  strokeWeight(hypThick);
  for (int q = 0; q < 3; q++) {  //the quarters of the hyperbola Q < 5
    for (int i = 0; i < width; i=i+width/div) {
      x2=0;
      y2=0;
      for (int t = i; t < width; t++) {
        y2 = y;
        x2 = x;
        y = t;
        x = sqrt(abs(i*i - y*y));
        if (dist(x, y, x2, y2) < 55) {
          line(x, y, x2, y2);
        }
      }
    }
    for (int i = 0; i < width; i=i+width/div) {
      x2=0;
      y2=0;
      for (int t = i; t < width; t++) {
        y2 = y;
        x2 = x;
        y = t;
        x = -sqrt(abs(i*i - y*y));
        if (dist(x, y, x2, y2) < 55) {
          line(x, y, x2, y2);
        }
      }
    }
    rotate(q*PI);     //(q*PI/2);
  }
}


