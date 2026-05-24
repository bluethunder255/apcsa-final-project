class Coin extends Item{
  int quantity;
  
  Coin(PVector l, int q){
    super(l);
    quantity = q;
  }
  
  int getQuantity(){
    return quantity;
  }
  
  void display(){
    stroke(0);
    strokeWeight(2);
    fill(255, 255, 0);
    circle(location.x, location.y, 20);
  }
}
