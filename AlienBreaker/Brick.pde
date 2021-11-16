class Brick {
  PVector pos = new PVector(0,0);
  float brickWidth;
  int brickHeight;
  int colour;
  boolean isVisible;
  
  // Constructor
  // Parameters: col - number of colums , number of rows
  Brick(int col,int row) {
    brickWidth = width/8;
    brickHeight = 40;
    pos.x = brickWidth * col;
    pos.y = brickHeight * row;
    isVisible = true;
    colour = color(85,25,55,90);
  }
  
  // Method to display Brick
  void displayBrick() {
    fill(colour);
    stroke(250,250,250,120);
    rectMode(CORNER);
    if(isVisible) {
      rect(pos.x,pos.y,brickWidth,brickHeight); 
    }
  }
  
  // Method to detects collision of ball with brick
  // Parameter: Alien ball class
  void brickCollision (Alien ball) {
    
    if(isVisible) { 
      // If ball hits the bottom side of the brick 
      if(ball.xLoc > pos.x && ball.xLoc < pos.x+ brickWidth && ball.yLoc < (pos.y + brickHeight + ball.diameter/2) && ball.yLoc > pos.y + brickHeight) {
         ball.moveByY = ball.moveByY * -1;
         breakEffect.play();
         isVisible = false;
      }
      
      // if ball hits the top side of the brick
      if(ball.xLoc > pos.x && ball.xLoc < pos.x+ brickWidth && ball.yLoc > pos.y - ball.diameter/2 && ball.yLoc < pos.y) {
         ball.moveByY = ball.moveByY * -1;
         breakEffect.play();
         isVisible = false;
      }
      // If ball hits the left side of the brick 
      if(ball.xLoc > pos.x - ball.diameter/2 && ball.yLoc > pos.y && ball.yLoc < pos.y+brickHeight && ball.xLoc < pos.x) {
         ball.moveByX = ball.moveByX * -1;
         breakEffect.play();
         isVisible = false;
      }
      // if ball hits the right side of the brick
      if(ball.xLoc > pos.x + brickWidth && ball.yLoc > pos.y && ball.yLoc < pos.y+brickHeight && ball.xLoc < pos.x + brickWidth + ball.diameter/2) {
         ball.moveByX = ball.moveByX * -1;
         breakEffect.play();
         isVisible = false;
      }
    }
     
  } // end of brickCollision(Alien ball) method

} // end of class
