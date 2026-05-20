class Platform{
  PVector location;
  int size;
  //String type;
  
  Platform(PVector l){
    location = l;
    size = int(random(30)) + 50;
  }
  
  //void scroll(float amount){
    //location.y += amount;
  //}
  
  void display(){
    stroke(1);
    strokeWeight(2);
    fill(50, 25, 0);
    rectMode(CENTER);
    rect(location.x, location.y, size, 10, 2);
  }
}
