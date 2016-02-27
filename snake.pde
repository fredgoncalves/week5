final int maxSegments = 100;
int[] xSegments = new int[maxSegments];
int[] ySegments = new int[maxSegments];

final int gridSize = 20;

void setup() {
  size(500, 500);
  for (int i = 0; i < maxSegments; i += 1) {
    xSegments[i] = ySegments[i] = -1;
  }
  xSegments[0] = width/2 / gridSize;
  ySegments[0] = width/2 / gridSize;
  snakeLength = 1;
  foodX = 10;
  foodY = 20;
  ellipseMode(CORNER);
}

int lastMove = 0;
int timeBetweenMoves = 500;

int xSpeed = 1;
int ySpeed = 0;
int snakeLength;

int foodX;
int foodY;
int foodU;
int foodV;

void draw() {
  background(255);
  for(int i=0;i<width/gridSize;i++){
  stroke(200);
  line(0,i*gridSize,height,i*gridSize);
  line(i*gridSize,0,i*gridSize,width);
  }
  noStroke();

  fill(0);
  for (int i = 0; i < maxSegments; i += 1) {
    rect(xSegments[i]*gridSize, ySegments[i]*gridSize, gridSize, gridSize);
  }

  fill(255, 0, 0);
  ellipse(foodX * gridSize, foodY * gridSize, gridSize, gridSize);
  fill(0,255,0);
  ellipse(foodU * gridSize, foodV * gridSize, gridSize, gridSize);

  if (millis() - lastMove > timeBetweenMoves) {
    lastMove = millis();
    int nextX = xSegments[0] + xSpeed;
    int nextY = ySegments[0] + ySpeed;

    for (int i = snakeLength-1; i > 0; i -= 1) {
      xSegments[i] = xSegments[i-1];
      ySegments[i] = ySegments[i-1];
    }
    if (isThereASegmentAtPosition(nextX, nextY) || nextX > width/gridSize || nextX < 0 || nextY > height/gridSize || nextY < 0) {
      // snake hit itself || snake hits the edge! reset the game!
      setup();
      timeBetweenMoves=500;
    } else {
      xSegments[0] = nextX;
      ySegments[0] = nextY;
      if (nextX == foodX && nextY == foodY || nextX == foodU && nextY == foodV) {
        getFood();
      }
    }
  }
}

void getFood() {
  snakeLength += 1;
  while (isThereASegmentAtPosition(foodX, foodY)) {
    foodX = floor(random(width/gridSize));
    foodY = floor(random(width/gridSize));
  }  
  while (isThereASegmentAtPosition(foodU, foodV)) {
    foodU = floor(random(width/gridSize));
    foodV = floor(random(width/gridSize));
  }
  timeBetweenMoves=timeBetweenMoves-50;
}

boolean isThereASegmentAtPosition(int x, int y) {
  for (int i = 0; i < snakeLength; i += 1) {
    if (xSegments[i] == x && ySegments[i] == y) {
      return true;
    }
  }
  return false;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      ySpeed = -1;
      xSpeed = 0;
    }
    if (keyCode == DOWN) {
      ySpeed = 1;
      xSpeed = 0;
    }
    if (keyCode == RIGHT) {
      ySpeed = 0;
      xSpeed = 1;
    }
    if (keyCode == LEFT) {
      ySpeed = 0;
      xSpeed = -1;
    }
  }
}
