class Player{
  PVector location, velocity, acceleration;
  
  Player(){
    location = new PVector(720, 100);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void move(){
  }
  
  void display(){
    stroke(1);
    strokeWeight(2);
    fill(0, 200, 0);
    circle(location.x, location.y, 50);
  }
}
