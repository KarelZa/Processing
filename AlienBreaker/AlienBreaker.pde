/**
 * Alien breaker game
 * @author Karel Zamazal
*/

import processing.sound.*; 
SoundFile menuSong,bounceEffect,breakEffect,gameOverSound,gameWonSound,buttonClickSound; 
Alien myAlienBall;
Paddle myPaddle;
Brick[][] bricks; 
Button play,exit,manual,retry,mainMenu,returnButton;
PImage bg,logo;
String gameState;
int ROWS = 5;
int COLS = 6;
int lives = 3;

void setup() {
  size(900,700);
  gameState = "MAIN";
  bg = loadImage("sky.jpg");
  logo = loadImage("logo.png");
  myAlienBall = new Alien(40);
  myPaddle = new Paddle(150,20); 
  generateBricks(); // create + populate bricks[][] array
  // BUTTONS
  play = new Button((width/2),(height/2),(width/3),(height/8),30,30,30,128);
  manual = new Button((width/2),(height/1.55),(width/3),(height/8),30,30,30,128);
  exit = new Button((width/2),(height/1.26),(width/3),(height/8),30,30,30,128);
  retry = new Button((width/3),(height/1.5),(width/4),(height/9),30,30,30,128);
  mainMenu = new Button((width/1.5),(height/1.5),(width/4),(height/9),30,30,30,128);
  returnButton = new Button((width/1.133),(height/8.5),(width/15),(height/15),255,0,0,128);
  // SOUNDFILES 
  menuSong = new SoundFile(this, "audio/song.wav");
  bounceEffect = new SoundFile(this, "audio/bounceSound.wav");
  breakEffect = new SoundFile(this, "audio/brickBreakSound.wav");
  gameOverSound = new SoundFile(this, "audio/loseSound.wav");
  gameWonSound = new SoundFile(this, "audio/winSound.wav"); 
  buttonClickSound = new SoundFile(this, "audio/buttonClickSound.wav"); 
  menuSong.play();
} // end of setup

void draw() { 
  image(bg,0,0); 
  bg.resize(width,0);
  gameManager();
} 

// Choose and display the content based on the gamestate
void gameManager() {
  if (gameState == "MAIN") {
    mainScreen();
  } else if (gameState == "PLAY") {
    gameScreen();
  } else if (gameState == "MANUAL") {
    manualScreen();
  } else if (gameState == "WIN") {
    victoryScreen();
  } else if (gameState == "LOSE") {
    gameOverScreen();
  } 
}

// Main menu screen
void mainScreen() {
  image(logo,0,0);
  noTint();
  play.buttonHover();
  play.buttonUpdate();
  play.buttonRender("PLAY",play.bWidth/10);
  if(play.isClicked()){
    startGame();
  } 
  manual.buttonHover();
  manual.buttonUpdate();
  manual.buttonRender("MANUAL",manual.bWidth/10);
  if(manual.isClicked() && gameState == "MAIN"){
    startManual();
  }
  exit.buttonHover();
  exit.buttonUpdate();
  exit.buttonRender("EXIT",exit.bWidth/10);
  if(exit.isClicked()){
    exit();
  }
} // end of mainScreen

// PLAY state - game itself
void gameScreen() {
  menuSong.stop();
  noTint();
  myAlienBall.display();  
  myAlienBall.move();
  myAlienBall.bounce();
  myPaddle.displayPaddle();
  myPaddle.move();
  myAlienBall.paddleBounce(myPaddle);
  showBricks();
  showLives();
  isFinished();
} // end of gameScreen


// Manual state -  guide how to play
void manualScreen() {
  fill(color(30,30,30,140));
  rectMode(CENTER);
  rect(width/2,height/2,width/1.2,height/1.2);
  textAlign(CENTER);
  textSize(height/20);
  fill(255);
  text("How to Play Brick Bricker:",width/2,height/4.5);
  textSize(height/30);
  text("1. Press any key to start game.",width/2,height/3);
  text("2. Move a PADDLE by moving your mouse.",width/2,height/2.5);
  text("3. To WIN you have to destroy all bricks",width/2,height/2.1);
  text("4. If you lose all of your lives , the game is OVER",width/2,height/1.8);
  returnButton.buttonUpdate();
  noStroke();
  returnButton.buttonRender("X",25);
  if(returnButton.isClicked()){
    gameState="MAIN";  
  }
} // end of manualScreen

// LOSE state - lost all 3 lives
void gameOverScreen() {
  tint(200,0,0);
  fill(255);
  textAlign(CENTER);
  textSize(height/6);
  text("GAME OVER",width/2,height/2);
  retryButton();
  mainMenuButton();
} // end of gameOverScreen

// WIN state - all bricks destroyed
void victoryScreen() {
  tint(50,250,50);
  fill(255);
  textAlign(CENTER);
  textSize(height/6);
  text("YOU WON",width/2,height/2);
  retryButton();
  mainMenuButton();
} // end of victoryScreen

// create + populate bricks[][] array
void generateBricks() {
  bricks = new Brick[ROWS][COLS];
  for(int row= 0;row < ROWS;row++){
    for(int col= 0;col < COLS;col++){
      bricks[row][col] = new Brick(col+1,row+3);
    }
  }
}

// display bricks[][] array and allows brickCollision with Alien ball
void showBricks() {
  for(int row= 0;row < ROWS;row++){
    for(int col= 0;col < COLS;col++){
      bricks[row][col].displayBrick();
      bricks[row][col].brickCollision(myAlienBall);
    }
  }
}

// return whether all bricks are destroyed - game successfuly finished
boolean isFinished() {
  for(int row= 0;row < ROWS;row++){
    for(int col= 0;col < COLS;col++){
      if(bricks[row][col].isVisible){
        return false;  
      }
    } 
  } 
  gameWonSound.play();
  gameState = "WIN";
  return true; 
}

// Display lives 
void showLives(){
  fill(255,255,255); 
  textSize(25);
  text("Lives: " + lives, 55, 15);  
  if(lives == 0){
    gameOverSound.play();
    gameState="LOSE";  
  }
}


void startGame() {
  gameState = "PLAY";
}

void startManual() {
  gameState = "MANUAL";
}

// If any key is pressed , ball starts to move
void keyPressed() {
  if(lives>0) {
    myAlienBall.isMoving = true;
  }
}

// retryButton + reset of the game
void retryButton() {
  retry.buttonHover();
  retry.buttonUpdate();
  retry.buttonRender("RETRY",retry.bWidth/10);
  if(retry.isClicked()){
    lives = 3;
    myAlienBall.yLoc = height-50;
    myAlienBall.isMoving = false;
    generateBricks();
    gameState="PLAY";  
  }
}

// mainMenuButton + reset of the game 
void mainMenuButton() {
  mainMenu.buttonHover();
  mainMenu.buttonUpdate();
  mainMenu.buttonRender("MAIN MENU",mainMenu.bWidth/10);
  if(mainMenu.isClicked()){
    lives = 3;
    myAlienBall.yLoc = height-50;
    myAlienBall.isMoving = false;
    generateBricks();
    menuSong.play();
    gameState="MAIN";  
  }
}
