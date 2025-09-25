import processing.sound.*;
SoundFile song;
SoundFile scorelist;
Enemy [] enemy = new Enemy [30];
Coin coin1;
Heart heart1;
float x, y, z;    //op 參數
int cx;
int blood;
int level;
int justwin;
PImage backgroundImage;
PImage space;
PImage rocket;
PImage rocket2;
PImage heart;
PImage coin;
boolean gameStarted = false;
boolean gameOver = false;
boolean displayText = true;
boolean op1;
boolean op2;
int score;
int[] Score = new int[11];
int empty;

void setup(){
  x=-2;
  y=0;
  z=255;
  op1 = false;
  op2 = false;
  coin1 = new Coin();
  heart1 = new Heart();
  score = 0;
  for( int i=0;i<11;i++){
    Score[i] = 0;
  }
  
  size(800,600);
  backgroundImage = loadImage("background.jpg");
  delay(6000);
  song = new SoundFile(this, "Megalovania.mp3");
  song.loop();
  scorelist = new SoundFile(this, "123.wav");
  space = loadImage("太空.jpg");
  imageMode(CENTER);
  rocket = loadImage("rocket.png");
  rocket2 = loadImage("飛彈.png");
  heart = loadImage("愛心.png");
  coin = loadImage("coin.png");
  blood = 5;
  level = 1;
  for(int i = 0; i < 30; i++){
    enemy[i] = new Enemy();
  }
}

void draw(){
  if(justwin==1){
    if(gameOver){
      delay(3000);
      justwin=0;
      blood=6-level;
      scorelist.play();
    }else{
      delay(3000);
      justwin=0;
      blood=6-level;
    }
  }
  
  
  if(!gameStarted) {
    background(0);
    image(backgroundImage,400,300,800,600);
   
    textSize(70);
    fill(255);
    textAlign(CENTER);
    text("Space Guardian", width/2, 150);
if (frameCount % 60 < 30) {
      displayText = true;
    } else {
      displayText = false;
    }
    
    if (displayText) {
      textSize(20);
      fill(255);
      textAlign(CENTER);
      text("Click to Start", width/2, 500);
    }
    textSize(20);
    fill(255);
    textAlign(CENTER);
    text("Instructions:", width/2, 200);
    text("- Move mouse. Your rocket will follow  it", width/2, 250);
    text("- Collect hearts to gain extra bloodpoints", width/2, 280);
    text("- Collect coins to gain scores, or lose bloodpoints", width/2, 310);
    text("- Avoid rockets from enemies", width/2, 340);
    text("- Reach 10 bloodpoints to proceed to the next level", width/2, 370);
    text("- Pass 3 levels to win the game", width/2, 400);
  } else if(!op1) {
    image(backgroundImage,400,300,800+4*pow(x,5),600+3*pow(x,5));
    x+=0.06;
    fill(0);
    if(x>0){
      rectMode(CENTER);
      rect(400,300,4*pow(x,5),3*pow(x,5));
    }
    if(x>3){
      op1 = true;
    }
  } else if(!op2) {
    fill(255,z);
    rectMode(CENTER);
    rect(400,300,4*pow(y,5),3*pow(y,5));
    y+=0.1;
    if(y>4){
      image(space, 400, 300, 800, 600);
      rect(400,300,width,height);
      z-=2;
    }
    if(z<0){
      op2 = true;
    }
    
    
  } else if(gameOver) {
    background(0);    
    song.stop();
    image(backgroundImage,400,300,800,600);
    textSize(60);
    fill(255);
    textAlign(CENTER);
    text("Game Over", width/2, 80);
    
    textSize(30);      // 分數排行榜
    fill(255);
    textAlign(CENTER);
    text("BEST   PLAYERS", width/2, 140);
    stroke(255);
    fill(255);
    line(300,150,500,150);
    text("RANK    SCORE", width/2, 180);
    for(int i=0;i<9;i++){
      text(i+1 + "st", width/2-55, i*30+210);
      text(Score[i], width/2+50, i*30+210);
    }
    text("YOUR SCORE    "+score, width/2, 490);
    
    
    textSize(30);
    fill(255);
    textAlign(CENTER);
    text("Press any key to restart", width/2, 530);

  } else {
    // 繪製遊戲介面
    if(scorelist.isPlaying()){
      scorelist.stop();
    }
    image(space, 400, 300, 800, 600);
    image(rocket, cx, 500, 60, 60);
    heart1.display();
    coin1.display();
    fill(255);
    line(0, 550, 800, 550);
    cx = mouseX;
    coin1.move();
    heart1.move();
    coin1.touch();
    heart1.touch();
    coin1.ifdown();
    heart1.ifdown();
    for(int i = 0; i < level*5+15; i++) {
      enemy[i].move();
      enemy[i].display();
      enemy[i].attack();
    }
    textSize(30); // 顯示血量
    text("Blood: " + blood, 400, 580);
    
    textSize(30); // 顯示分數
    text("Score: " + score, 740, 30);

    textSize(30); // 顯示等級
    text("Level: " + level, 60, 30);

    if(blood == 0) { // 遊戲結束
      gameOver = true;
      song.stop();
      Score[10] = score;    //結算分數
      scorelist.play();
      for( int i=9;i>=0;i--){
        if(Score[i+1] > Score[i]){
          empty = Score[i+1];
          Score[i+1] = Score[i];
          Score[i] = empty;
        }
      }
    }
    
    if(blood == 10) { // 進入下一級
      level++;
      blood = 6 - level;
      background(0);
      textSize(50);
      fill(255);
      textAlign(CENTER);
      text("Level up!", width/2, height/2);
      justwin = 1;
      coin1.respawn();
      heart1.respawn();
      if(level < 4){
        for(int i = 0; i < level*5+15; i++) {
          enemy[i].respawn();
        }
      }
    }
    if(level == 4) { // 遊戲勝利
      background(0);
      textSize(50);
      fill(255);
      textAlign(CENTER);
      text("You Win", width/2, height/2-50);
      text("Your Score:" + score, width/2, height/2+50);
      song.stop();
      gameOver = true;
      
      Score[10] = score;    //結算分數
      for( int i=9;i>=0;i--){
        if(Score[i+1] > Score[i]){
          empty = Score[i+1];
          Score[i+1] = Score[i];
          Score[i] = empty;
        }
      }
    }
  }
}

void keyReleased() {
  if(gameOver) {
    restartGame(); // 按下任意鍵重新開始遊戲
  }
}

void mousePressed() {
  if (!gameStarted) {
    gameStarted = true; // 開始遊戲
  }
}
void restartGame() {
  gameOver = false;
  score = 0;
  blood = 5;
  level = 1;
  cx = 400;
  coin1.respawn();
  heart1.respawn();
  for(int i = 0; i < 10; i++){
    enemy[i].reset();
  }
  song.play();
}
