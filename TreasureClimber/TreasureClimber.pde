Player player;
ArrayList<Platform> platforms;
int currentFloor;
int totalColumns, floorHeight;
int score, highScore;
int coinsCollected;

void setup(){
  size(960, 720);
  player = new Player();
  player.display();
  platforms = new ArrayList<>();
  currentFloor = 0;
  platforms.add(new Platform(new PVector(width / 2, height * 0.95), currentFloor));
  currentFloor++;
  totalColumns = 7;
  float columnWidth = width / totalColumns;
  floorHeight = 175;
  for (int i = 0; i < totalColumns * 3; i++){
    int col = i % totalColumns;
    float x = col * columnWidth + columnWidth / 2;
    float y = height * 0.7 - i / totalColumns * floorHeight;
    currentFloor = i / totalColumns;
    platforms.add(new Platform(new PVector(x, y), currentFloor));
  }
  score = highScore = 0;
  coinsCollected = 0;
}

void draw(){
  background(100, 50, 0);
  for (Platform platform : platforms){
    platform.display();
  }
  player.move();
  player.edgeBounce();
  for (Platform p: platforms) player.platformInteraction(p);
  player.display();
  nextFloor();
  fill(255);
  textSize(20);
  text("Coins: " + coinsCollected, 20, 40);
  //text("Score: " + score, 20, 40);
  //text("Highscore: " + score, 800, 40);
}

void nextFloor(){
  Platform highest = platforms.get(platforms.size() - 1);
  if (highest.location.y > floorHeight){
    currentFloor++;
    platforms.add(new Platform(new PVector(width / 2, 0), currentFloor));
  }
}

void keyPressed(){
  player.play();
  player.changeDirection();
}
