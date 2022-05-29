int state = 1;
ArrayList<Grass> terrain = new ArrayList<Grass>();
ArrayList<Sheep> herd = new ArrayList<Sheep>();

ArrayList<Sheep> new_borns = new ArrayList<Sheep>();
ArrayList<Sheep> dead_sheep = new ArrayList<Sheep>();

color WHITE = color(255,255,255);
color BROWN = color(102, 51, 0);
color RED = color(255, 0, 0);
color GREEN = color( 0,102, 0);
color YELLOW= color(255,255, 0);
color PURPLE= color(102, 0,204);

Sheep shaun;
Grass g11;
void setup() {
  size(400, 400);
  frameRate(480); // simulation speed.
  rectMode(CENTER);
}
void draw() {
  background(175, 129, 35);
  if (state == 1) {
    add_blocks(terrain);
    add_sheep(herd, 5, WHITE); // 50% chance to produce twins
    add_sheep(herd, 5, RED); // faster sheep
    add_sheep(herd, 5, BROWN); // more durable sheep
    add_sheep(herd, 5, PURPLE); // smarter sheep
    state++;
  }
  grass_update();
  sheep_to_grass_check();
  sheep_to_sheep_check();
  sheep_update();
}











void add_blocks(ArrayList<Grass> ter) {
  for (int x = 0; x<= width; x+=10) {
    for (int y= 0; y<=height; y+=10) {
      ter.add(new Grass(x, y));
    }
  }
}

void add_sheep(ArrayList<Sheep> herd, int num, color col) {
  for (int i = 0; i< num; i++) {
    herd.add(new Sheep(col));
  }
}

void sheep_to_grass_check() {
  for (Sheep sheep : herd) {
    for (Grass block : terrain) {
      sheep.check_eating(block.check_collision(sheep.x_pos, sheep.y_pos));
    }
  }
}
void grass_update() {
  for (Grass block : terrain) {
    block.update();
  }
}
void sheep_to_sheep_check() {
  for (Sheep sheep1 : herd) {
    for (Sheep sheep2 : herd) {
      if (sheep1 != sheep2 && sheep1.col == sheep2.col) {
        if (sheep1.check_mating(sheep2) == 1) {
          new_borns.add(new Sheep(sheep1.x_pos, sheep1.y_pos, sheep1.col));
          if(sheep1.col == WHITE){
            if(int(random(1,3)) == 1){
              new_borns.add(new Sheep(sheep1.x_pos, sheep1.y_pos , sheep1.col));
            }
          }
        }
      }
    }
  }
  if(herd.size()> 100){
  }
  else{
  herd.addAll(new_borns);
  }
  new_borns.removeAll(new_borns);
  herd.removeAll(dead_sheep);
}
void sheep_update() {
  for (Sheep sheep : herd) {   sheep.update();
  }
}
