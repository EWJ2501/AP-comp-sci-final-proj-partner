Ball[] balls;

void setup() {
  size(800, 600, P3D);
  balls = new Ball[10];
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(0);
  lights();
  translate(width / 2, height / 2, -200);  // Center the scene

  for (Ball b : balls) {
    b.update();
    b.display();
  }
}

class Ball {
  PVector pos;
  PVector vel;
  float radius;
  color c;

  Ball() {
    pos = new PVector(random(-200, 200), random(-200, 200), random(-200, 200));
    vel = new PVector(random(-2, 2), random(-2, 2), random(-2, 2));
    radius = random(10, 30);
    c = color(random(255), random(255), random(255));
  }

  void update() {
    pos.add(vel);

    // Bounce off the bounds of a 500x500x500 cube
    if (abs(pos.x) > 250) vel.x *= -1;
    if (abs(pos.y) > 250) vel.y *= -1;
    if (abs(pos.z) > 250) vel.z *= -1;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    fill(c);
    noStroke();
    sphere(radius);
    popMatrix();
  }
}
