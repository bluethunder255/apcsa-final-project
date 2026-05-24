class Player{
  PVector location, velocity, gravity;
  int radius = 30;
  
  Player(){
    location = new PVector(width / 2, height * 0.9);
    velocity = new PVector(0, 0);
    gravity = new PVector(0, 0);
  }
  
  void play(){
    if (velocity.mag() == 0){
      velocity.add(-6, -15);
      gravity.add(0, 0.5);
    }
  }
  
  void move(){
    velocity.add(gravity);
    location.add(velocity);
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
  
  void platformInteraction(Platform platform){
    if (velocity.y > 0){
      float platformLeft = platform.location.x - platform.size / 2;
      float platformRight = platform.location.x + platform.size / 2;
      float platformTop = platform.location.y - 5;
      float platformBottom = platform.location.y + 5;
      if (location.x + radius > platformLeft && location.x - radius < platformRight){
        if (location.y + radius >= platformTop && location.y < platformBottom){
          velocity.y = -15;
          location.y = platformTop - radius;
        }
      }
    }
    else if (location.y <= height / 2 && velocity.y < 0) platform.scroll(-velocity.y);
  }
  
  int collectCoin(Platform platform){
    int quantity = 0;
    Coin coin = platform.getCoin();
    if (coin != null){
      float coinLeft = coin.location.x - 10;
      float coinRight = coin.location.x + 10;
      float coinTop = coin.location.y - 10;
      float coinBottom = coin.location.y + 10;
      if (location.x + radius > coinLeft && location.x - radius < coinRight){
        if (location.y + radius >= coinTop && location.y < coinBottom){
          quantity = coin.getQuantity();
          platform.removeItem();
        }
      }
    }
    return quantity;
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
