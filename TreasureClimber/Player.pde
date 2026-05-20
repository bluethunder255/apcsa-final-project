class Player{
  PVector location, velocity, gravity;
  final int radius = 30;
  
  Player(){
    location = new PVector(width / 2, height * 0.9);
    velocity = new PVector(3, -15);
    gravity = new PVector(0, 0.5);
  }
  
  void move(){
    velocity.add(gravity);
    location.add(velocity);
    //if (location.y < height / 2 && velocity.y < 0) location.y = height / 2;
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
  
  void platformBounce(Platform platform){
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
