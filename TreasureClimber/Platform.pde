class Platform{
  private PVector location;
  private int floor;
  private int size;
  private String type;
  private Item item;
  
  Platform(){
    location = new PVector(width / 2, height * 0.95);
    floor = 0;
    size = 80;
    type = "normal";
  }
  
  Platform(PVector l, int f, float c){
    location = l.copy();
    floor = f;
    size = int(random(30)) + 50;
    int rand = int(random(10));
    if (rand == 0) type = "spikes";
    else if (rand < 2) type = "trapdoor";
    else type = "normal";
    if (random(1) < c) item = new Coin(l.add(0, -20), 1);
    else if (random(1) < 0.01) item = new Powerup(l.add(0, -20), "jetpack");
    else if (random(1) < 0.01) item = new Powerup(l.add(0, -20), "timer");
    //else if (random(1) < 0.05) item = new Powerup(l.add(0, -20), "magnet");
    //else if (random(1) < 0.01) item = new Powerup(l.add(0, -20), "shield");
  }
  
  float getY(){
    return location.y;
  }
  
  int getFloor(){
    return floor;
  }
  
  String getType(){
    return type;
  }
  
  Item getItem(){
    return item;
  }
  
  void removeItem(){
    item = null;
  }
  
  void scroll(float amount){
    this.location.y += amount;
    if (item != null) item.location.y += amount;
  }
  
  void display(){
    stroke(0);
    strokeWeight(2);
    if (type.equals("normal")) fill(50, 25, 0);
    if (type.equals("trapdoor")) fill(200, 100, 0);
    if (type.equals("spikes")) fill(100, 100, 100);
    if (type.equals("conveyor")) fill(0, 200, 255);
    rectMode(CENTER);
    rect(location.x, location.y, size, 10, 2);
    fill(255);
    textSize(10);
    text(floor, location.x, location.y);
    if (item != null) item.display();
  }
}
