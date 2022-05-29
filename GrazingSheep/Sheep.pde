class Sheep {
  float x_pos;
  float y_pos;
  float size;
  float energy;
  float speed = 1 ;
  int dir = int(random(1, 5));// direction
  int alive = 1;
  float age;
  float mating; // cooldown duration
  int ts = 0;// internal clock of the sheep
  color col;
  int IQ = 15; // More IQ means that the sheep is less indecisive, check brain function

  Sheep(color c) {
    x_pos = random(width/4);
    y_pos = random(height/4);
    size = 10;
    energy = 100;
    mating = 300;
    age = 2;
    col = c;
    if (c == WHITE) {
      speed = 1.0; // little buff
    }
    if (col == RED) {
      speed = 1.3;
      x_pos = random(3*width/4, width);
      y_pos = random(3*height/4, height);
    }
    if (col == PURPLE) {
      IQ = 50;
      x_pos = random(3*width/4, width);
      y_pos = random(height/4);
    }
    if (col == BROWN) {
      energy = 125;
      x_pos = random(width/4);
      y_pos = random(3*height/4, height);
    }
  }
  Sheep( float x, float y, color c) {
    x_pos = x;
    y_pos = y;
    energy = 100;
    size = 7;
    mating = 0;
    age = 1;
    col = c;
    if (c == WHITE) {
      speed = 1; // little buff
    }
    if (c == RED) {
      speed = 1.4;
    }
    if (c == PURPLE) {
      IQ = 50;
    }
    if (c == BROWN) {
      energy = 125;
    }
  }

  void render() {
    pushMatrix();
    translate(x_pos, y_pos);
    if (dir == 1) {
      rotate(radians(180));
    }
    if (dir == 2) {
      rotate(radians(-90));
    }
    if (dir == 3) {
      rotate(radians(0));
    }

    if (dir == 4) {
      rotate(radians(90));
    }


    fill(col);
    circle(0, 0, size);
    fill(0);

    circle(0, size/2, size/2);
    popMatrix();
  }

  void check_eating(int nutri) {
    if (nutri > 0 && energy <= 100) {
      energy += nutri; //Bigger the sheep, less energy from grass
    }
  }
  int check_mating(Sheep mate) {
    if (mate.y_pos > y_pos - 10 && mate.y_pos < y_pos + 10 && mate.x_pos > x_pos - 10 && mate.x_pos < x_pos + 10) {
      if (energy >50 && mate.energy > 50) {
        if (age >= 2 && mate.age >= 2 && mating == 300 && mate.mating == 300) {
          mating = 0;
          mate.mating = 0;
          return 1;
        }
        return 0;
      }
      return 0;
    }
    return 0;
  }


  void update() {
    if (alive == 1) {
      this.brain();
      this.legs();
      this.render();
      if (mating < 300) {
        mating +=1;
      }
      energy -= 0.04; // UNIVERSAL ENERGY DIMINISHING PARAMETER
      if (frameCount > ts + 1800) {
        ts = frameCount;
        if (age == 1) {// they grow up so fast..
          size = 10;
        } else { // then it is just downhill from after age of 30...
          size =size + size*age/20;
        }
        age += 1;
      }
      if (energy < 0 || age == 10) {
        alive = 0;
      }
    }
    if (alive == 0) {
      fill(0);
      text("x_x",x_pos-5, y_pos);
      energy += 1; // Just animation timer without any extra parameters
      if (energy >= 100) {
        alive =  -1;
      }
    }

    if (alive == -1) { // to delete the dead from array 
      dead_sheep.add(this);
    }
  }


  void legs() {
    if (dir == 1) {
      y_pos -= 0.2*speed*(energy/50); // lack of energy makes you slow.
    }
    if (dir == 2) {
      x_pos += 0.2*speed*(energy/50);
    }
    if (dir == 3) {
      y_pos +=0.2*speed*(energy/50);
    }
    if (dir == 4) {
      x_pos -= 0.2*speed*(energy/50);
    }
  }


  void brain() {

    if (int(random(IQ)) == 1) {
      dir = int(random(1, 5));
    }
    if (x_pos > width) {// directions of movement.
      dir = 4;
    }
    if (x_pos < 0) {
      dir = 2;
    }
    if (y_pos > height) {
      dir = 1;
    }
    if (y_pos < 0) {
      dir = 3;
    }
  }
}
