private Player player;
private ArrayList<Platform> platforms;
private int totalCols, currentFloor, generatingFloor;
private float colWidth, floorHeight;
private int score, highScore;
private float coinChance;
private boolean game;

void setup(){
  size(960, 720);
  background(100, 50, 0);
  fill(0, 255, 0);
  rectMode(CENTER);
  rect(width / 2, height * 0.6, 200, 40, 3);
  fill(0);
  textSize(45);
  textAlign(CENTER, CENTER);
  text("Play", width / 2, height * 0.6);
}

void draw(){
  if (game){
    background(100, 50, 0);
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
          reset();
          return;
        }
      }
      player.collectItem(p);
      p.display();
    }
    player.display();
    if (player.location.y > height){
      reset();
      return;
    }
    nextFloor();
    drawUI();
  }
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
  player.play();
  player.changeDirection();
}

void mouseClicked(){
  game = true;
  reset();
}

void drawUI(){
  fill(255);
  textSize(20);
  textAlign(LEFT);
  text("Coins: " + player.getCoins(), 20, 40);
  text("Floor: " + currentFloor, 20, 80);
  text("Highscore: " + highScore, 800, 40);
}

void reset(){
  if (player != null) highScore = max(highScore, currentFloor + player.getCoins());
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
  score = 0;
}
