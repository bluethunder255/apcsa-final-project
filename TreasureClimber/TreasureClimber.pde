Player player;
ArrayList<Platform> platforms;
int totalColumns;
int score, highScore;
int coinsCollected;

void setup(){
  size(960, 720);
  player = new Player();
  player.display();
  platforms = new ArrayList<>();
  platforms.add(new Platform(new PVector(width / 2, height * 0.95)));
  totalColumns = 7;
  float columnWidth = width / totalColumns;
  for (int i = 0; i < totalColumns * 3; i++){
    int col = i % totalColumns;
    float x = col * columnWidth + columnWidth / 2;
    float y = height * 0.7 - i / totalColumns * 150;
    platforms.add(new Platform(new PVector(x, y)));
  }
  score = highScore = 0;
  coinsCollected = 0;
}

void draw(){
  background(100, 50, 0);
  for (Platform p : platforms){
    p.display();
  }
  //nextFloor();
  player.move();
  player.edgeBounce();
  for (Platform p: platforms) player.platformBounce(p);
  player.display();
  fill(255);
  textSize(20);
  text("Coins: " + coinsCollected, 20, 40);
  //text("Score: " + score, 20, 40);
  //text("Highscore: " + score, 800, 40);
}

//void nextFloor(){
  //for (int i = 0; i < 7; i++) platforms.add(new Platform(new PVector(100, 100)));
//}

void keyPressed(){
  player.changeDirection();
}
