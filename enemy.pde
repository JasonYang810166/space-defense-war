class Enemy{
  int x;
  int y;
  int dy;
  Enemy(){
    x=int(random(1,6))*100+100;
    y=-int(random(400,5000));
    dy=int(random(level*3+4,level*3+6));
  }
  
  void move(){
    y+=dy;
  } 
  
   void reset() {
    respawn();
  }
  
  void display(){
    image(rocket2,x,y,50,50);
  }
  
  
  void attack(){
    if(y >= 530){
      x=int(random(1,6))*100+100;
      y=-int(random(400,5000));
      dy=int(random(level*3+4,level*3+6));
    }
    if(dist(cx,500,x,y)<=20){
      blood--;
      score-=3;
      x=int(random(1,6))*100+100;
      y=-int(random(400,5000));
      dy=int(random(level*3+4,level*3+6));
    }
  }
  
  
  void respawn(){
    x=int(random(1,6))*100+100;
    y=-int(random(400,5000));
    dy=int(random(level*3+4,level*3+6));
  }
  
}
