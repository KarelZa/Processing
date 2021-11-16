class Alien {
  float xLoc,yLoc,diameter; // properties of body
  float eyeXLoc,eyeYLoc,eyeWidth,eyeHeight; // properties of eye
  float mouthXLoc,mouthYLoc,mouthWidth,mouthHeight; // properties of mouth
  float toothXLoc,toothYLoc; // properties of teeth
  float moveByX,moveByY; // properties to move object
  color col; // property for color
  boolean isMoving;
 
  // Constructor
  // Parameter: bSize - size of ball
  Alien(int bSize){
    xLoc = width/2;
    yLoc = height-50;
    diameter = bSize;
    moveByX = random(-15,15);
    moveByY = -11;
    col = color(255,0,0,200);
    isMoving = false;
  }
  
  
  // Method to display AlienBall  - I have put smaller methods for each part into one bigger
  void display() { 
    noStroke();
    fill(col);
    ellipse(xLoc,yLoc,diameter,diameter);
    // to draw eye
    eyeXLoc = xLoc; // 200
    eyeYLoc = yLoc - (diameter/5); 
    eyeWidth = diameter/1.8; // 100
    eyeHeight = eyeWidth;  // 100 
    fill(255,180,0);
    // for loop to draw an eye and smaller iris inside it
    for(int i=0;i<=1;i++){
      ellipse(eyeXLoc,eyeYLoc, eyeWidth, eyeHeight);
      fill(0,0,0);
      eyeWidth= eyeWidth*0.25;
      eyeHeight= eyeHeight*0.80;
    }
    //to draw mouth
    fill(0);
    rectMode(CENTER);  
    mouthXLoc = xLoc; 
    mouthYLoc = yLoc + (diameter/4);
    mouthWidth = diameter/4;
    mouthHeight = mouthWidth/5; 
    rect(mouthXLoc,mouthYLoc,mouthWidth,mouthHeight);
    // to draw teeth
    toothXLoc = mouthXLoc-(mouthWidth/2); // seting Xloc for first tooth(triangle)
    toothYLoc = mouthYLoc-(mouthHeight/2); // seting Yloc for first tooth(triangle)
    fill(255);
    for(int i=0;i<5;i++){
      triangle(toothXLoc,toothYLoc,toothXLoc+(mouthHeight/2),toothYLoc+(mouthWidth/2),toothXLoc+mouthHeight,toothYLoc); 
      toothXLoc= toothXLoc+(mouthWidth/5); // moving Xloc for another tooth
    }
  }
 

  // Method to move ball
  void move() {
    if(isMoving) {
      xLoc = xLoc + moveByX; 
      yLoc = yLoc + moveByY;  
    } else {
      xLoc = constrain(mouseX,85,width-85); // so ball will stick with paddle 
    }
  } 
   
  // Method to bounce ball whenever it hits sides of the canvas
  void bounce(){
    
    // Right side of the canvas
    if (xLoc >= ((width-diameter/2) )) {
      moveByX = moveByX * -1;  
    }  
    
     // Left side of the canvas
    if (xLoc <= (diameter/2)) {
      moveByX = moveByX * -1;  
    } 
    
    // Top side of the canvas
    if (yLoc <= diameter/2) {
      moveByY = moveByY * -1;     
    }
    
    // Bottom of the canvas , reduce lives
    if(myAlienBall.yLoc>(height+diameter/2)) {
      myAlienBall.yLoc = height-50;
      myAlienBall.isMoving = false;
      lives--;
    }
  } // end of bounce()
  
  
  // Makes AlienBall bounce of the paddle
  // Parameter: Paddle class
  void paddleBounce(Paddle pad){
    if(xLoc > (pad.pos.x - pad.pWidth/2) && xLoc < (pad.pos.x + pad.pWidth/2) && yLoc > pad.pos.y - diameter/2   && yLoc < pad.pos.y + diameter/2) {
      moveByY = moveByY * -1;
      moveByX = (xLoc - mouseX) * 0.1;
      bounceEffect.play();
    }
  } 
 
} // end of class
