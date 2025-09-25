class Coin{
  int x;
  int y;
  Coin(){
    x = int(random(1,6))*100+100;
    y = -int(random(0, 800));
  }
  
  void display(){
    image(coin, x, y, 40, 40);
  }
  
  void move(){
    y+= level * 2 + 3.5;
  }
  
  void touch(){
    if(dist(cx, 500, x, y) <= 30) {
      score+=5;
      x = int(random(1,6))*100+100;
      y = -int(random(0, 800));
    }
  }
  
  void ifdown(){
    if(y >= 550) {
      blood--;
      x = int(random(1,6))*100+100;
      y = -int(random(0, 800));
    }
  }
  
  void respawn(){
    x = int(random(1,6))*100+100;
    y = -int(random(0, 800));
  }
  
}
