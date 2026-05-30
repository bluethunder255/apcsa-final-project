class Powerup extends Item{
  private String type;
  
  Powerup(PVector l, String t){
    super(l);
    type = t;
  }
  
  String getType(){
    return type;
  }
  
  void display(){
    imageMode(CENTER);
    if (type.equals("jetpack")) image(imgJetpack, getX(), getY());;
    if (type.equals("magnet")) image(imgMagnet, getX(), getY());
    if (type.equals("shield")) image(imgShield, getX(), getY());
    if (type.equals("timer")) image(imgTimer, getX(), getY());
  }
}
