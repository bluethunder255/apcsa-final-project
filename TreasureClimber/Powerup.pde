class Powerup extends Item{
  String type;
  
  Powerup(PVector l, String t){
    super(l);
    type = t;
  }
  
  String getType(){
    return type;
  }
  
  void display(){
    stroke(0);
    strokeWeight(2);
    if (type.equals("jetpack")) fill(100, 100, 100);
    if (type.equals("magnet")) fill(255, 0, 0);
    if (type.equals("shield")) fill(0, 255, 255);
    if (type.equals("timer")) fill(255, 128, 0);
    circle(location.x, location.y, 20);
  }
}
