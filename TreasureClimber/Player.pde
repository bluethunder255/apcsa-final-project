class Player{
  PVector location, velocity, gravity;
  final int radius = 30;
  
  Player(){
    location = new PVector(width / 2, height * 0.9);
    velocity = new PVector(1, -20);
    gravity = new PVector(0, 1);
  }
  
  void move(){
    if (location.y > height / 2){
      velocity.add(gravity);
      location.add(velocity);
      //gravity.mult(0);
    }
    else{
      location.y = height / 2;
      //Platform.scroll();
    }
  }
  
  void bounce(){
    if (location.x <= radius){
      velocity.x *= -1;
      location.x = radius;
    }
    if (location.x >= width - radius){
      velocity.x *= -1;
      location.x = width - radius;
    }
    /* if (location.y == platform.location.y && velocity.y > 0){
      velocity.y *= -1;
      location.y = platform.location.y;
    }
    */
  }
  
  void display(){
    stroke(1);
    strokeWeight(2);
    fill(0, 200, 0);
    circle(location.x, location.y, radius * 2);
  }
  
  void reverse(){
    if (key == ' ') velocity.x *= -1;
    //if (keyCode == LEFT) velocity.x *= -1;
    //if (keyCode == RIGHT) velocity.x *= -1;
  }
}
