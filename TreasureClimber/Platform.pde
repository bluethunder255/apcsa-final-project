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
  
  Platform(PVector l, int f, int p){
    location = l.copy();
    floor = f;
    size = int(random(30)) + 45;
    if (p == 0) type = "normal";
    else{
      float platformRand = random(1);
      if (p == 1){
        if (platformRand < 0.3) type = "trapdoor";
        else type = "normal";
      }
      else if (p == 2){
        if (platformRand < 0.2) type = "spikes";
        else if (platformRand < 0.3) type = "conveyor";
        else if (platformRand < 0.5) type = "trapdoor";
        else type = "normal";
      }
      else if (p == 3){
        if (platformRand < 0.3) type = "spikes";
        else if (platformRand < 0.5) type = "conveyor";
        else if (platformRand < 0.9) type = "trapdoor";
        else type = "normal";
      }
      else{
        if (platformRand < 0.5) type = "conveyor";
        else type = "spikes";
      }
    }
    PVector itemPos = l.add(0, -20);
    float itemRand = random(1);
    if (itemRand < 0.4) item = new Coin(itemPos, 1);
    else if (itemRand < 0.41) item = new Powerup(itemPos, "jetpack");
    else if (itemRand < 0.42) item = new Powerup(itemPos, "timer");
    else if (itemRand < 0.43) item = new Powerup(itemPos, "magnet");
    else if (itemRand < 0.44) item = new Powerup(itemPos, "shield");
  }
  
  float getX(){
    return location.x;
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
    imageMode(CENTER);
    if (type.equals("normal")) image(imgNormal, location.x, location.y, size, 10);
    else if (type.equals("trapdoor")) image(imgTrapdoor, location.x, location.y, size, 10);
    else if (type.equals("spikes")) image(imgSpikes, location.x, location.y, size, 10);
    else if (type.equals("conveyor")) image(imgConveyor, location.x, location.y, size, 10);
    fill(255);
    textSize(10);
    text(floor, location.x, location.y);
    if (item != null) item.display();
  }
}
