String screen;
Player player;
ArrayList<Platform> platforms;
int totalCols, currentFloor, generatingFloor;
float colWidth, floorHeight;
int highScore;
//int progression;
PImage imgTitle, imgPlay;
PImage imgPlayerLeft, imgPlayerRight;
PImage imgNormal, imgTrapdoor, imgSpikes, imgConveyor;
PImage imgCoin, imgJetpack, imgMagnet, imgShield, imgTimer;

void setup(){
  size(960, 720);
  imgTitle = loadImage("sprites/title.png");
  imgPlay = loadImage("sprites/play.png");
  imgPlayerLeft = loadImage("sprites/player-left.png");
  imgPlayerRight = loadImage("sprites/player-right.png");
  imgNormal = loadImage("sprites/platform-normal.png");
  imgTrapdoor = loadImage("sprites/platform-trapdoor.png");
  imgSpikes = loadImage("sprites/platform-spikes.png");
  imgConveyor = loadImage("sprites/platform-conveyor.png");
  imgCoin = loadImage("sprites/coin.png");
  imgJetpack = loadImage("sprites/jetpack.png");
  imgMagnet = loadImage("sprites/magnet.png");
  imgShield = loadImage("sprites/shield.png");
  imgTimer = loadImage("sprites/timer.png");
  screen = "title";
}

void draw(){
  if (screen.equals("game")){
    if (player == null) reset();
    background(50, 25, 0);
    player.move();
    player.edgeBounce();
    for (int i = platforms.size() - 1; i >= 0; i--){
      Platform p = platforms.get(i);
      if (p.getY() > height){
        platforms.remove(i);
        continue;
      }
      if (player.platformInteraction(p)){
        if (p.getFloor() > currentFloor) currentFloor = p.getFloor();
        if (p.getType().equals("trapdoor")){
          platforms.remove(i);
          continue;
        }
        if (p.getType().equals("spikes")){
          gameOver();
          return;
        }
      }
      player.collectItem(p);
      p.display();
    }
    player.display();
    if (player.location.y > height){
      gameOver();
      return;
    }
    nextFloor();
  }
  drawUI();
}

void gameOver(){
  screen = "fail";
  if (player != null) highScore = max(highScore, currentFloor + player.getCoins());
}

void nextFloor(){
  if (platforms.isEmpty()) return;
  Platform highest = platforms.get(platforms.size() - 1);
  float highestY = highest.getY();
  int highestFloor = highest.getFloor();
  if (highestY > floorHeight){
    generatingFloor++;
    ArrayList<Integer> anchors = new ArrayList<>();
    for (Platform p : platforms){
      if (p.getFloor() == highestFloor){
        int col = int(p.getX() / colWidth);
        if (!anchors.contains(col)) anchors.add(col);
      }
    }
    float targetY = highestY - floorHeight;
    ArrayList<Integer> spawns = new ArrayList<>();
    for (int anchor : anchors){
      int left = max(0, anchor - 2);
      int right = min(totalCols - 1, anchor + 2);
      int safe = int(random(left, right + 1));
      if (!spawns.contains(safe)){
        float targetX = safe * colWidth + colWidth / 2;
        platforms.add(new Platform(new PVector(targetX, targetY), generatingFloor, 0.4));
        spawns.add(safe);
      }
    }
    for (int i = 0; i < totalCols; i++){
      float targetX = i * colWidth + colWidth / 2;
      if (!spawns.contains(i) && random(1) < 0.4) platforms.add(new Platform(new PVector(targetX, targetY), generatingFloor, 0.4));
    }
  }
}

void keyPressed(){
  if (screen.equals("game") && player != null){
    player.play();
    player.changeDirection();
  }
}

void mouseClicked(){
  if (!screen.equals("game")){
    screen = "game";
    reset();
  }
}

void drawUI(){
  if (screen.equals("title")){
    background(50);
    imageMode(CENTER);
    image(imgTitle, width / 2, height * 0.2);
    image(imgPlay, width / 2, height * 0.6);
  }
  else if (screen.equals("game") && player != null){
    fill(255);
    textSize(20);
    textAlign(LEFT, TOP);
    text("Coins: " + player.getCoins(), 20, 20);
    text("Floor: " + currentFloor, 20, 50);
    textAlign(RIGHT, TOP);
    text("High Score: " + highScore, width - 20, 20);
  }
  else if (screen.equals("fail")){
    fill(0);
    rectMode(CENTER);
    rect(width / 2, height * 0.5, 300, 400, 5);
    fill(255);
    textAlign(CENTER);
    textSize(40);
    text("Game Over", width / 2, height * 0.3);
    textAlign(LEFT);
    textSize(30);
    text("Coins:", width * 0.4, height * 0.4);
    text("Floor:", width * 0.4, height * 0.5);
    text("Score:", width * 0.4, height * 0.6);
    textAlign(RIGHT);
    text(player.getCoins(), width * 0.6, height * 0.4);
    text(currentFloor, width * 0.6, height * 0.5);
    text(player.getCoins() + currentFloor, width * 0.6, height * 0.6);
    textAlign(CENTER);
    textSize(20);
    text("Click anywhere to restart", width * 0.5, height * 0.7);
  }
}

void reset(){
  player = new Player();
  platforms = new ArrayList<>();
  totalCols = 7;
  colWidth = width / totalCols;
  currentFloor = 0;
  generatingFloor = 3;
  floorHeight = 175;
  platforms.add(new Platform());
  for (int i = 0; i < totalCols * 3; i++){
    int col = i % totalCols;
    float x = col * colWidth + colWidth / 2;
    float y = height * 0.7 - i / totalCols * floorHeight;
    platforms.add(new Platform(new PVector(x, y), i / totalCols + 1, 0.4));
  }
}
