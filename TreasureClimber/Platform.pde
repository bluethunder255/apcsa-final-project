class Platform{
  PVector location;
  int size;
  //String type;
  
  Platform(PVector l){
    location = l;
    size = int(random(40)) + 50;
  }
  
  void display(){
    stroke(1);
    strokeWeight(2);
    fill(50, 25, 0);
    rectMode(CENTER);
    rect(location.x, location.y, size, 10, 2);
  }
  
  void scroll(){
    location.y += 1;
  }
}
