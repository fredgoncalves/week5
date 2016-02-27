float[] values;
int index;
int space = 0; //sets the regularity of lines
int spacing = 5; //sets the number of lines 
float y = height/2; //birds position

void setup() {
  size(600, 400);
  background(0);

  values = new float[width/spacing];
  index = 0;
  frameRate(24);
}

float maybeRandomHeight() {
  if (space%50==0) {
    return random(height/3, 2*height/3);
  } else {
    return 0;
  }
}

void draw() {
  background(255);
  values[index] = maybeRandomHeight();
  index = index + 1;
  if (index >= values.length) {
    index = 0;
  }

  for (int i = 0; i < values.length; ++i) {
    int realIndex = index + i;
    if (realIndex >= values.length) {
      realIndex -= values.length;
    }
    line(i*spacing, height-values[realIndex], i*spacing, height);
    if (values[realIndex]!=0) {
      line(i*spacing, height-values[realIndex]-100, i*spacing, 0);
      if (i*spacing == width/2 && y-30<= height-values[realIndex]-100) { //identifies collisions with upper line
        println("collide with upper line");
      }
      if (i*spacing == width/2 && y+30>= height-values[realIndex]) { //identifies collisions with bottom line
        println("collide with bottom line");
      }
    }
  }
  ellipse(width/2, y, 30, 30);
  y=y+4;
  space++;
}

void keyPressed() {
  for (int i = 10; i>0; i--) {
    y=y-i;
  }
}
