Player player;
ArrayList<Platform> platforms = new ArrayList<>();
int score, highScore;
int coinsCollected;

void setup(){
  size(960, 720);
  player = new Player();
  player.display();
  platforms.add(new Platform(new PVector(width / 2, height * 0.95)));
  for (int i = 0; i < 21; i++){
    platforms.add(new Platform(new PVector(90 + 130 * (i % 7), 540 - 180 * (i / 7))));
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
  player.bounce();
  player.display();
  fill(255);
  textSize(20);
  text("Coins: " + coinsCollected, 20, 40);
  //text("Score: " + score, 20, 40);
  //text("Highscore: " + score, 800, 40);
}

void nextFloor(){
  for (int i = 0; i < 7; i++){
    platforms.add(new Platform(new PVector(100, 100)));
  }
}

void keyPressed(){
  player.reverse();
}
