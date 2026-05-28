class Player{
  private PVector location, velocity, gravity;
  private int radius = 30;
  private int coinsCollected = 0;
  private float timeScale = 1.0;
  
  Player(){
    location = new PVector(width / 2, height * 0.9);
    velocity = new PVector(0, 0);
    gravity = new PVector(0, 0);
  }
  
  int getCoins(){
    return coinsCollected;
  }
  
  void play(){
    if (velocity.mag() == 0){
      velocity.add(-6, -15);
      gravity.add(0, 0.5);
    }
  }
  
  void move(){
    velocity.add(gravity.copy().mult(timeScale));
    location.add(velocity.copy().mult(timeScale));
    if (location.y < height / 2 && velocity.y < 0) location.y = height / 2;
  }
  
  void edgeBounce(){
    if (location.x <= radius){
      velocity.x *= -1;
      location.x = radius;
    }
    if (location.x >= width - radius){
      velocity.x *= -1;
      location.x = width - radius;
    }
  }
  
  boolean platformInteraction(Platform platform){
    if (velocity.y > 0){
      float platformLeft = platform.location.x - platform.size / 2;
      float platformRight = platform.location.x + platform.size / 2;
      float platformTop = platform.location.y - 5;
      float platformBottom = platform.location.y + 5;
      if (location.x + radius > platformLeft && location.x - radius < platformRight){
        if (location.y + radius >= platformTop && location.y < platformBottom){
          velocity.y = -15;
          location.y = platformTop - radius;
          return true;
        }
      }
    }
    else if (location.y <= height / 2 && velocity.y < 0) platform.scroll(-velocity.y * timeScale);
    return false;
  }
  
  void collectItem(Platform platform){
    Item i = platform.getItem();
    if (i != null){
      float iLeft = i.location.x - 10;
      float iRight = i.location.x + 10;
      float iTop = i.location.y - 10;
      float iBottom = i.location.y + 10;
      if (location.x + radius > iLeft && location.x - radius < iRight){
        if (location.y + radius >= iTop && location.y < iBottom){
          if (i instanceof Coin) coinsCollected += collectCoins(i);
          if (i instanceof Powerup) collectPower(i);
          platform.removeItem();
        }
      }
    }
  }
  
  int collectCoins(Item i){
    Coin c = (Coin) i;
    return c.getQuantity();
  }
  
  void collectPower(Item i){
    Powerup power = (Powerup) i;
    String type = power.getType();
    if (type.equals("jetpack")) velocity.y = -50;
    if (type.equals("timer")) timeScale *= 0.9;
    //if (type.equals("magnet")){
      //return;
    //}
  }
  
  void changeDirection(){
    if (key == ' ') velocity.x *= -1;
  }
  
  void display(){
    stroke(0);
    strokeWeight(2);
    fill(0, 200, 0);
    circle(location.x, location.y, radius * 2);
  }
}
