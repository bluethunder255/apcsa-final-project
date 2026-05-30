class Coin extends Item{
  private int quantity;
  
  Coin(PVector l, int q){
    super(l);
    quantity = q;
  }
  
  int getQuantity(){
    return quantity;
  }
  
  void display(){
    imageMode(CENTER);
    image(imgCoin, getX(), getY());
  }
}
