class Paddle {
  PVector pos = new PVector(0,0);
  int pWidth;
  int pHeight;
  
  // Constructor 
  // Parameters: w = width of paddle , h = height of paddle
  Paddle (int w,int h) {
    pos.x = width/2;
    pos.y = height-20;
    pWidth = w;
    pHeight = h;
  }
  
  // Method to display paddle
  void displayPaddle() {
    fill(50);
    rectMode(CENTER);
    rect(pos.x,pos.y,pWidth,pHeight,10);
  } 
  
  // Method to move paddle based on mouse movement
  void move() {
      pos.x = mouseX;
      pos.x = constrain(pos.x,pWidth/2,width-pWidth/2); // This won't let paddle go off the canvas
  }

}
