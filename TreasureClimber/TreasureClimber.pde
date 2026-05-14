Player player;
ArrayList<Platform> platforms;
int score, highScore;
int coinsCollected;
  
void setup(){
  size(1080, 720);
  player = new Player();
  player.display();
}
