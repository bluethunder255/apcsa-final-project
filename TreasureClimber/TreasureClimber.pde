Player player;
ArrayList<Platform> platforms;
int score, highScore;
int coinsCollected;
  
void setup(){
  size(960, 720);
  player = new Player();
  player.display();
}

void draw(){
  background(100, 50, 0);
  //for (Platform p : platforms){
    //p.display();
  //}
  //nextFloor();
  player.move();
  player.bounce();
  player.display();
  fill(255);
  text(1, 20, 40);
}

void nextFloor(){
  for (int i = 0; i < 1; i++){
    //platforms.add(new Platform(new PVector(100, 100), 50));
  }
}
