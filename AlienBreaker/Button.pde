class Button {
  PVector pos = new PVector(0,0);
  float bWidth;
  float bHeight;
  color col;
  String text;
  Boolean pressed = false;
  Boolean clicked = false;

  // Parameterised constuctor for  button
  // Parameters: xPos - x position, yPos - y position , w - width of button , h - height of button , r - red , g - green , b - blue , o - opacity
  Button(float xPos,float yPos,float w,float h,int r,int g,int b,int o) {
    pos.x = xPos;
    pos.y = yPos;
    bWidth = w;
    bHeight = h;
    col = color(r,g,b,o);
  }
  
  
  // Method to indicates if button was clicked
  void buttonUpdate() {
    if(mousePressed == true && mouseButton == LEFT && pressed == false){
      pressed = true;
      if(mouseX >= pos.x-bWidth/2 && mouseX <= pos.x + bWidth/2 && mouseY >= pos.y- bHeight/2 && mouseY <= pos.y + bHeight/2) {
        buttonClickSound.play();
        clicked = true;
      }
    } else {
        clicked = false;
    }
    
    if(mousePressed != true) {
        pressed = false;
    }
  } // end of update
  
  // Method to display button 
  // Parameters:  txt - text displayed on button , txtS - size of text
  void buttonRender(String txt,float txtS) {
    fill(col);
    rectMode(CENTER);
    rect(pos.x,pos.y,bWidth,bHeight);
    fill(255);
    textAlign(CENTER,CENTER);  
    textSize(txtS);
    text(txt,pos.x,pos.y); // placement of text in middle
  }
  
  // return if button was clicked
  boolean isClicked() {   
    return clicked;
  }
  
  // Method to have hover state of button 
  void buttonHover() {
    if(mouseX >= pos.x-bWidth/2 && mouseX <= pos.x + bWidth/2 && mouseY >= pos.y- bHeight/2 && mouseY <= pos.y + bHeight/2){
      stroke(210);  
    } else {
      stroke(0);
    }
  }
  
  
}
