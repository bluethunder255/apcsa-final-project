class Platform{
  PVector location;
  int floor;
  int size;
  //String type;
  Item item;
  
  Platform(){
    location = new PVector(width / 2, height * 0.95);
    floor = 0;
    size = 80;
  }
  
  Platform(PVector l, int f, float c){
    location = l.copy();
    floor = f;
    size = int(random(30)) + 50;
    if (random(1) < c) item = new Coin(l.add(0, -20), 1);
    else if (random(1) < 0.01) item = new Powerup(l.add(0, -20), "jetpack");
    else if (random(1) < 0.01) item = new Powerup(l.add(0, -20), "timer");
    //else if (random(1) < 0.05) item = new Powerup(l.add(0, -20), "magnet");
    //else if (random(1) < 0.01) item = new Powerup(l.add(0, -20), "shield");
  }
  
  void scroll(float amount){
    this.location.y += amount;
    if (item != null) item.location.y += amount;
  }
  
  Item getItem(){
    return item;
  }
  
  void removeItem(){
    item = null;
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
    if (item != null) item.display();
  }
}
