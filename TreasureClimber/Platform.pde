class Platform{
  PVector location;
  int floor;
  int size;
  //String type;
  Coin coin;
  
  Platform(PVector l, int f, float c){
    location = l.copy();
    floor = f;
    size = int(random(30)) + 50;
    if (random(1) < c) coin = new Coin(l.add(0, -20));
  }
  
  void scroll(float amount){
    this.location.y += amount;
    if (coin != null) coin.location.y += amount;
  }
  
  Coin getCoin(){
    return coin;
  }
  
  void removeItem(){
    coin = null;
  }
  
  void display(){
    stroke(0);
    strokeWeight(2);
    fill(50, 25, 0);
    rectMode(CENTER);
    rect(location.x, location.y, size, 10, 2);
    //fill(255);
    //textSize(10);
    //text(floor, location.x, location.y);
    if (coin != null) coin.display();
  }
}
