class Player{
  private PVector location, velocity, gravity;
  private int radius;
  private int coinsCollected, timersCollected;
  private float timeScale;
  private boolean hasShield;
  
  Player(){
    location = new PVector(width / 2, height * 0.9);
    velocity = new PVector(0, 0);
    gravity = new PVector(0, 0);
    radius = 27;
    coinsCollected = timersCollected = 0;
    timeScale = 1.0;
  }
  
  int getCoins(){
    return coinsCollected;
  }
  
  boolean popShield(){
    boolean popped = hasShield;
    hasShield = false;
    return popped;
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
  
  void progress(int p){
    timeScale = pow(1.1, p) * pow(0.9, timersCollected);
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
  
  boolean platformInteraction(Platform p){
    if (velocity.y > 0){
      float platformLeft = p.location.x - p.size / 2;
      float platformRight = p.location.x + p.size / 2;
      float platformTop = p.location.y - 5;
      float platformBottom = p.location.y + 5;
      if (location.x + radius > platformLeft && location.x - radius < platformRight){
        if (location.y + radius > platformTop && location.y < platformBottom){
          velocity.y = -15;
          location.y = platformTop - radius;
          return true;
        }
      }
    }
    else if (location.y <= height / 2 && velocity.y < 0) p.scroll(-velocity.y * timeScale);
    return false;
  }
  
  void collectItem(Platform p){
    Item i = p.getItem();
    if (i != null){
      float iLeft = i.location.x - 10;
      float iRight = i.location.x + 10;
      float iTop = i.location.y - 10;
      float iBottom = i.location.y + 10;
      if (location.x + radius > iLeft && location.x - radius < iRight){
        if (location.y + radius >= iTop && location.y < iBottom){
          if (i instanceof Coin) coinsCollected += collectCoins(i);
          if (i instanceof Powerup) collectPower(i);
          p.removeItem();
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
    if (type.equals("magnet")){
      return;
    }
    if (type.equals("shield")) hasShield = true;
    if (type.equals("timer")) timersCollected++;
  }
  
  void changeDirection(){
    if (key == ' ') velocity.x *= -1;
  }
  
  void display(){
    imageMode(CENTER);
    if (velocity.x < 0) image(imgPlayerLeft, location.x, location.y);
    else image(imgPlayerRight, location.x, location.y);
    if (hasShield) image(imgBubble, location.x, location.y);
  }
}
