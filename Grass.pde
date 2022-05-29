class Grass {
  float x_pos;
  float y_pos;
  int eaten = 0;
  int nutrition = int(random(1, 4)); // some blocks of grass are more nutritious than others.
  int block_size = 10;
  int growth = 0;

  Grass(float x, float y) {
    x_pos = x;
    y_pos = y;
  }
  int check_collision(float sheep_x, float sheep_y) {
    if (eaten == 0) {
      if (sheep_y > y_pos - 5 && sheep_y < y_pos +5 && sheep_x > x_pos - 5 && sheep_x < x_pos + 5) {
        eaten = 1;
        return nutrition;
      }
    }
    return 0;
  }
  void update() {
    if (eaten ==0) {
      render();
    }
    if (eaten == 1) {
      growth += 1;
      if (growth > 1500) { // grass growth timer
        growth = 0;
        eaten = 0;
      }
    }
  }

  void render() {
    noStroke();
    fill(0, 102, 0, 100 + nutrition*25);
    square(x_pos, y_pos, block_size);
  }
}
