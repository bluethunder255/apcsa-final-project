Player player;
ArrayList<Platform> platforms;
int totalCols, currentFloor;
float colWidth, floorHeight;
int score, highScore;
float coinChance;

void setup(){
  size(960, 720);
  player = new Player();
  platforms = new ArrayList<>();
  totalCols = 7;
  colWidth = width / totalCols;
  currentFloor = 0;
  floorHeight = 175;
  platforms.add(new Platform(new PVector(width / 2, height * 0.95), currentFloor, 0));
  for (int i = 0; i < totalCols * 3; i++){
    int col = i % totalCols;
    float x = col * colWidth + colWidth / 2;
    float y = height * 0.7 - i / totalCols * floorHeight;
    platforms.add(new Platform(new PVector(x, y), i / totalCols + 1, 0.4));
  }
  score = highScore = 0;
}

void draw(){
  background(100, 50, 0);
  player.move();
  player.edgeBounce();
  for (Platform platform : platforms){
    player.platformInteraction(platform);
    player.collectItem(platform);
    platform.display();
  }
  player.display();
  if (player.location.y > height) reset();
  nextFloor();
  fill(255);
  textSize(20);
  text("Coins: " + player.getCoins(), 20, 40);
  text("Floor: " + currentFloor, 20, 80);
  text("Highscore: " + highScore, 800, 40);
}

void nextFloor(){
  Platform highest = platforms.get(platforms.size() - 1);
  if (highest.location.y > floorHeight){
    currentFloor++;
    ArrayList<Integer> cols = new ArrayList<>();
    while (cols.size() < 1){
      for (int i = 0; i < totalCols; i++){
        if (random(1) < 0.6 && !(cols.contains(i))) cols.add(i);
      }
    }
    for (Integer col : cols) platforms.add(new Platform(new PVector(col * colWidth + colWidth / 2, 0), currentFloor + 3, 0.4));
  }
}

void keyPressed(){
  player.play();
  player.changeDirection();
}

void reset(){
  highScore = currentFloor + player.getCoins();
  player = new Player();
  platforms = new ArrayList<>();
  totalCols = 7;
  colWidth = width / totalCols;
  currentFloor = 0;
  floorHeight = 175;
  platforms.add(new Platform(new PVector(width / 2, height * 0.95), currentFloor, 0));
  for (int i = 0; i < totalCols * 3; i++){
    int col = i % totalCols;
    float x = col * colWidth + colWidth / 2;
    float y = height * 0.7 - i / totalCols * floorHeight;
    platforms.add(new Platform(new PVector(x, y), i / totalCols + 1, 0.4));
  }
  score = 0;
}
