int ammo = 32;
int health = 100;
int numEnemies = 3;
boolean gameEnd = false;
boolean startScreen = true;
//PVector
PMatrix3D baseMat;
int pillarCoordX[] = {0,0,800,800};
int pillarCoordZ[] = {0,800,800,0};
int enemyCoordX[] = {-420,940,800,0};
int enemyCoordZ[] = {-500,60,640,1200};
//int cameraCoord[] = {0,0,0};
float zPOS = 400;
float xPOS = 400;
float zVector = 0;
float xVector = 0;
float xANGLE = 0;
float zANGLE = 0;
float ANGLE = 180;
float fraction = 0.0;
float xSpeed = 5;
float zSpeed = 5;
boolean Wtrue = false;
boolean Atrue = false;
boolean Strue = false;
boolean Dtrue = false;
boolean turnLeft = false;
boolean turnRight = false;
float yRotation = 0.0;
int vector = 170;
int boundingBoxCoordX[] = {2000,-2000,0,0,0,0};
int boundingBoxCoordY[] = {0,0,0,0,200,-200};
int boundingBoxCoordZ[] = {0,0,2000,-2000,0,0};
PShape pillar;
PImage pillarTex;
PShape boundingBox;
PImage flooringTex;
PShape boundingBox2;
PImage wallTex;
PShape bullet1;
PGraphics World;
PGraphics UIlayer;
PImage gun;
PFont techyFont;
//import java.util.ArrayList; 
// ArrayList<Float> bulletX = new ArrayList<>(); // Create an Array
// ArrayList<Float> bulletZ = new ArrayList<>(); // Create an Array

void setup () {
    size (1200, 780,P3D);
    World = createGraphics(1200, 780, P3D);
    UIlayer = createGraphics(1200, 780,P2D);
    xPOS = 0;
    zPOS = height/2;
    pillarTex = loadImage("irongrate.jpg");
    pillar = createShape(BOX,200);
    flooringTex = loadImage("metalfloor.jpg");
    boundingBox = createShape(BOX,2000,200,2000);
    wallTex = loadImage("metalgrate2.jpg");
    boundingBox2 = createShape(BOX,2000,200,2000);
    boundingBox2.setTexture(wallTex);
    wallTex = loadImage("metalgrate3.jpg");
    boundingBox2 = createShape(BOX,2000,200,2000);
    boundingBox2.setTexture(wallTex);
    boundingBox.setTexture(flooringTex);
    pillar.setTexture(pillarTex);
    bullet1 = loadShape("Bullet.obj");
    bullet1.scale(500);
    gun = loadImage("gun.png");
    gun.resize(2000,1170);
    techyFont = createFont("MinasansItalic-7OmmP.otf", 48);
}


void makeEnemy (int xPos, int zPos){
    World.fill (255, 0, 0);
    World.translate (xPos, height/2+25, zPos);
    World.box (65, 150, 65);
    World.shape(bullet1);
    World.fill(255,255,255);
    World.translate(-xPos, -(height/2+25), -zPos);
    World.fill (255, 0, 0);
    World.translate (xPos, height/2+25, zPos);
    World.box (65, 150, 65);
    World.shape(bullet1);
    World.fill(255,255,255);
    World.translate(-xPos, -(height/2+25), -zPos);
}

void makeEnemies (){
    for (int i=0; i<4; i++){
        makeEnemy(enemyCoordX[i], enemyCoordZ[i]);
    }
    World.fill (100);
}

    // float UIX = 0;
    // float UIZ = 0;
    // float bulletPOSX = 0;
    // float bulletPOSZ = 0;
void shoot (){
    ammo -= 1;
    // World.translate(xPOS, (height/2), zPOS-150);
    // UIZ= 100*xANGLE;
    // UIX= 100*zANGLE;
    // World.translate(xPOS+UIX, (height/2)+50, zPOS+UIZ);
    // bulletX.add(bulletPOSX);
    // bulletZ.add(bulletPOSZ);
    // appendBulletCoords();
    // World.shape(bullet1);
    // World.translate(-(xPOS), -(height/2), -(zPOS-150));
    // World.rotateY(ANGLE*PI/180);
    // World.translate(-(xPOS+UIX), -((height/2)+50), -(zPOS+UIZ));
    // World.rotateY(-(ANGLE*PI/180));
}

// void appendBulletCoords(int bulletID){
//     if(bulletPOSX<)
// }

void reloadText(){
    UIlayer.fill (255, 0, 0);
    UIlayer.textSize(40);
    UIlayer.text ("PRESS 'R'", 970, 670);
    UIlayer.text ("TO RELOAD", 970, 730);
    World.fill (100);
}

void draw () {
    if (startScreen){
        background(0);
        World.beginDraw();
        World.background(0);
        World.noFill();
        //World.stroke (500);
        //World.line (xPOS, height/2, zPOS, xPOS+(xVector*0.001), height/2, zPOS+(zVector*0.001));
        World.lights();
        movement();
        World.ambientLight(0, 0, 0);
        World.spotLight(220,220,220,xPOS, height/2, zPOS,xPOS+xVector, height/2, zPOS+zVector, PI/3, 1);
        World.camera(xPOS, height/2, zPOS, xPOS+xVector, height/2, zPOS+zVector, 0, 1, 0);
        summonWalls();
        summonPillars();
        //World.stroke(255);
        makeEnemies();
        World.endDraw();


        UIlayer.beginDraw();
        UIlayer.clear(); // allows transparency
        //UIlayer.fill(192);
        UI();
        UIlayer.endDraw();
        image(World, 0, 0);
        image(UIlayer, 0, 0); // This will appear on top
    } else if (!startScreen && ! gameEnd){

    } else if (gameEnd){

    }
}

float walkVal = 0;
int updown = 1;
void UI(){
        UIlayer.translate(600,760);
        UIlayer.rectMode(CENTER);
        UIlayer.noFill();
        UIlayer.textFont(techyFont);
        UIlayer.textAlign(CENTER, CENTER);
        UIlayer.rect(0, 0, 200, 40);
        UIlayer.translate(-600,-760);
        if(Wtrue== true||Atrue== true||Strue== true||Dtrue== true){
            walkVal= walkVal + updown;
            if (walkVal>=10){
                updown = -1;
            }
            if (walkVal<=-10){
                updown = 1;
            }
        }
        UIlayer.image(gun,-400,-(300+walkVal));

        //UIlayer.fill(255);
        UIlayer.rectMode (CORNER);
        UIlayer.strokeWeight (10);
        UIlayer.rect(0, 600, 1200, 180);

        // health
        UIlayer.rectMode (CENTER);
        //UIlayer.fill (100);
        UIlayer.rect (width/2, 690, 300, 180);
        UIlayer.textAlign (CENTER);
        UIlayer.textSize (32);
        UIlayer.fill (255);
        UIlayer.text ("HEALTH", width/2, 660);

        // ammo
        UIlayer.text ("AMMO", 170, 660);
        UIlayer.textSize(50);
        UIlayer.text (ammo + "/32", 170, 740);

        if (ammo==0){
            UIlayer.fill (255, 0, 0);
        } else {
            UIlayer.fill (255);
        }
        UIlayer.textSize(40);
        UIlayer.text ("PRESS 'R'", 970, 670);
        UIlayer.text ("TO RELOAD", 970, 730);
}

void summonPillars(){
    for(int i = 0; i<4; i++){
        World.translate(pillarCoordX[i], height/2, pillarCoordZ[i]);
        World.shape(pillar);
        World.translate(-pillarCoordX[i],-(height/2),-pillarCoordZ[i]);
        }
}

void summonWalls(){
    for(int i = 0; i<6; i++){
        World.translate(400, (height/2), 400);
        World.translate(boundingBoxCoordX[i],boundingBoxCoordY[i],boundingBoxCoordZ[i]);
        if(i<=3){
            World.shape(boundingBox2);
        }else{
            World.shape(boundingBox);
        }
        World.translate(-boundingBoxCoordX[i],-boundingBoxCoordY[i],-boundingBoxCoordZ[i]);
        World.translate(-400, -(height/2), -400);
        }
}


void movement(){
    //fraction = (zANGLE/xANGLE);
    //ANGLE = atan(fraction);
    if(turnLeft == true){
        ANGLE=(ANGLE+1.0)%360.0;
    }
    if(turnRight == true){
        ANGLE=(ANGLE-1.0)%360.0;
    }
    //println("degree",ANGLE);
    xANGLE =(sin(ANGLE*PI/180.0));
    zANGLE =(cos(ANGLE*PI/180.0));
    xSpeed = (5.0*xANGLE);
    zSpeed = (5.0*zANGLE);
    xVector = (10000*xANGLE);
    zVector = (10000*zANGLE);
    // println("xSpeed: ",xSpeed);
    // println("zSpeed: ",zSpeed);
    // println("XPos: ",xPOS);
    // println("ZPos: ",zPOS);
    // println("zVector: ",zVector);
    // println("xVector: ",xVector);
    if(Wtrue == true){
        if(outOfBoundsX(xPOS+xSpeed)||inPillarX(xPOS+xSpeed,zPOS)){
        }else{
        xPOS+=xSpeed;
        }
        if(outOfBoundsZ(zPOS+zSpeed)||inPillarZ(xPOS,zPOS+zSpeed)){
        }else{
        zPOS+=zSpeed;
        }
    }
    if(Strue == true){
        if(outOfBoundsX(xPOS-xSpeed)||inPillarX(xPOS-xSpeed,zPOS)){
        }else{
        xPOS-=xSpeed;
        }
        if(outOfBoundsZ(zPOS-zSpeed)||inPillarZ(xPOS,zPOS-zSpeed)){
        }else{
        zPOS-=zSpeed;
        }
    }
    ANGLE=(ANGLE+90.0)%360.0;
    xANGLE =(sin((ANGLE)*PI/180.0));
    zANGLE =(cos((ANGLE)*PI/180.0));
    xSpeed = (5.0*xANGLE);
    zSpeed = (5.0*zANGLE);
    if(Atrue == true){
        if(outOfBoundsX(xPOS+xSpeed)||inPillarX(xPOS+xSpeed,zPOS)){
        }else{
        xPOS+=xSpeed;
        }
        if(outOfBoundsZ(zPOS+zSpeed)||inPillarZ(xPOS,zPOS+zSpeed)){
        }else{
        zPOS+=zSpeed;
        }
    }
    if(Dtrue == true){
        if(outOfBoundsX(xPOS-xSpeed)||inPillarX(xPOS-xSpeed,zPOS)){
        }else{
        xPOS-=xSpeed;
        }
        if(outOfBoundsZ(zPOS-zSpeed)||inPillarZ(xPOS,zPOS-zSpeed)){
        }else{
        zPOS-=zSpeed;
        }
    }
    ANGLE=(ANGLE-90.0)%360.0;
}

void keyPressed(){
    if (startScreen){
        if (key== ' '){
            if (ammo != 0){
                shoot();
            } 
        } else if (key == 'r'){
            ammo = 32;
        }
        if(key == 'w'){
            Wtrue = true;
        }
        if(key == 's'){
            Strue = true;
        }
        if(key == 'd'){
            Dtrue = true;
        }
        if(key == 'a'){
            Atrue = true;
        }
        if(key == 'j'){
            turnLeft = true;
        }
        if(key == 'k'){
            turnRight = true;
        }
    }
}

void keyReleased(){
    if(key == 'w'){
        Wtrue = false;
    }
    if(key == 's'){
        Strue = false;
    }
    if(key == 'd'){
        Dtrue = false;
    }
    if(key == 'a'){
        Atrue = false;
    }
    if(key == 'j'){
        turnLeft = false;
    }
    if(key == 'k'){
        turnRight = false;
    }
}

boolean outOfBoundsX(float x){
    return (((x)>=1300)||((x)<=-500));
}

boolean outOfBoundsZ(float z){
    return (((z)>=1300)||((z)<=-500));
}

boolean inPillarX(float x, float z){
   return (((((x)>=-192)&&(x)<=192)&&((((z>=-192)&&(z<=192)))||(((z)>=613)&&((z)<=997))))||((((x)>=613)&&(x)<=997)&&((((z>=-192)&&(z<=192)))||(((z)>=613)&&((z)<=997)))));
}

boolean inPillarZ(float x, float z){
   return (((((z)>=-192)&&(z)<=192)&&((((x>=-192)&&(x<=192)))||(((x)>=613)&&((x)<=997))))||((((z)>=613)&&(z)<=997)&&((((x>=-192)&&(x<=192)))||(((x)>=613)&&((x)<=997)))));
}
