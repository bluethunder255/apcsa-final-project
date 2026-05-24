abstract class Item{
  PVector location;
  
  Item(PVector l){
    location = l.copy();
  }
  
  void display(){};
}
