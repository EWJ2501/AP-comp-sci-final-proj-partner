

void setup() {
  size(1800, 360, P3D);
}

void draw() {
  background(0);
  lights();
  directionalLight(0, 255, 0, 0, -1, 0);
  camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2, -100);
  stroke(255);
  box(200);
}