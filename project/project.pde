int z = 0;
float yRotation = 0.0;

void setup() {
  size(1200, 360, P3D);
}

void draw() {
  background(0);
  lights();
  spotLight(255, 0, 0, width/2, height/2, 400, 0, 0, -1, PI/4, 2);
  //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(width/2, height/2, -100);
  rotateY(yRotation);
  stroke(255);
  box(200);
  yRotation = yRotation + 0.01;
}