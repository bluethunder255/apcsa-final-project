abstract class Item{
  private PVector location;
  
  Item(PVector l){
    location = l.copy();
  }
  
  float getX(){
    return location.x;
  }
  
  float getY(){
    return location.y;
  }
  
  abstract void display();
}
