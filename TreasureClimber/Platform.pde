class Platform{
  PVector location;
  int size;
  //String type;
  
  Platform(PVector l, int s){
    location = l;
    size = s;
  }
  
  void display(){
    stroke(1);
    strokeWeight(2);
    fill(50, 25, 0);
    rect(location.x, location.y, size, 10, 1);
  }
}
