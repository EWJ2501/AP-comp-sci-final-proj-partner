int ammo = 50;
int health = 100;
int numEnemies = 3;
boolean gameEnd = false;
boolean startScreen = true;
//PVector
PMatrix3D baseMat;
int pillarCoordX[] = {0,0,805,805};
int pillarCoordZ[] = {0,805,805,0};
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
boolean ShootTrue = false;
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
import java.util.ArrayList;
import processing.sound.*;
SoundFile file;
ArrayList<Float> bulletX = new ArrayList<>(); // Create an Array
ArrayList<Float> bulletZ = new ArrayList<>(); // Create an Array
ArrayList<Float> bulletXVector = new ArrayList<>(); // Create an Array
ArrayList<Float> bulletZVector = new ArrayList<>(); // Create an Array
ArrayList<Float> bulletYangle = new ArrayList<>(); // Create an Array
int coolDown = 125;
int time;

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
   file = new SoundFile(this, "gunFireSound.mp3");
   time = millis();
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
   World.fill(255,255,255);
   World.translate(-xPos, -(height/2+25), -zPos);
}


void makeEnemies (){
   for (int i=0; i<4; i++){
       makeEnemy(enemyCoordX[i], enemyCoordZ[i]);
   }
   World.fill (100);
}


   float UIX = 0;
   float UIZ = 0;
void shoot (int bulletID){
   ammo -= 1;
   file.play(1,0,0,0, 3.0);
   calcSpeeds(((ANGLE)%360.0),20.0);
   UIZ= 100*xANGLE;
   UIX= 100*zANGLE;
   bulletX.add(xPOS);
   bulletZ.add(zPOS);
   bulletXVector.add(xSpeed);
   bulletZVector.add(zSpeed);
   bulletYangle.add(ANGLE+90.0);
}


void appendBulletCoords(int bulletID){
   if(!(((outOfBoundsX(bulletX.get(bulletID),1395,-595))||(inPillarX(bulletX.get(bulletID),bulletZ.get(bulletID),105)||((outOfBoundsZ(bulletZ.get(bulletID),1395,-595))||(inPillarZ(bulletZ.get(bulletID),bulletX.get(bulletID),105))))))){
       bulletX.set(bulletID, bulletX.get(bulletID) + bulletXVector.get(bulletID));
       bulletZ.set(bulletID, bulletZ.get(bulletID) + bulletZVector.get(bulletID));
       World.translate (bulletX.get(bulletID), ((height/2)+50), bulletZ.get(bulletID));
       World.rotateY(bulletYangle.get(bulletID)*PI/180);
       World.shape(bullet1);
       World.rotateY(-(bulletYangle.get(bulletID)*PI/180));
       World.translate (-bulletX.get(bulletID), -((height/2)+50), -bulletZ.get(bulletID));
   }else{
       bulletX.remove(bulletID);
       bulletZ.remove(bulletID);
       bulletXVector.remove(bulletID);
       bulletZVector.remove(bulletID);
       bulletYangle.remove(bulletID);
   }
}


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
       World.lights();
       movement();
       World.ambientLight(0, 0, 0);
       World.spotLight(220,220,220,xPOS, height/2, zPOS,xPOS+xVector, height/2, zPOS+zVector, PI/3, 1);
       World.camera(xPOS, height/2, zPOS, xPOS+xVector, height/2, zPOS+zVector, 0, 1, 0);
       summonWalls();
       summonPillars();
       makeEnemies();
       for(int i = 0; i<bulletX.size(); i++){
       appendBulletCoords(i);
       }
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
       UIlayer.text (ammo + "/50", 170, 740);


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



int bulletNum = 0;
void movement(){
    if(ShootTrue == true){
        if (ammo != 0){
            if((millis()-time)>= coolDown){
               time=millis();
               bulletNum = bulletX.size();
               shoot(bulletNum);
               bulletNum++;
            }
           }
    }
   //fraction = (zANGLE/xANGLE);
   //ANGLE = atan(fraction);
   if(turnLeft == true){
       ANGLE=(ANGLE+1.0)%360.0;
   }
   if(turnRight == true){
       ANGLE=(ANGLE-1.0)%360.0;
   }
   //println("degree",ANGLE);
   calcSpeeds(ANGLE,5.0);
   xVector = (10000*xANGLE);
   zVector = (10000*zANGLE);
   // println("xSpeed: ",xSpeed);
   // println("zSpeed: ",zSpeed);
    println("XPos: ",xPOS);
    println("ZPos: ",zPOS);
   // println("zVector: ",zVector);
   // println("xVector: ",xVector);
   if(Wtrue == true){
       if(outOfBoundsX(xPOS+xSpeed,1300,-500)||inPillarX(xPOS+xSpeed,zPOS,192)){
       }else{
       xPOS+=xSpeed;
       }
       if(outOfBoundsZ(zPOS+zSpeed,1300,-500)||inPillarZ(xPOS,zPOS+zSpeed,192)){
       }else{
       zPOS+=zSpeed;
       }
   }
   if(Strue == true){
       if(outOfBoundsX(xPOS-xSpeed,1300,-500)||inPillarX(xPOS-xSpeed,zPOS,192)){
       }else{
       xPOS-=xSpeed;
       }
       if(outOfBoundsZ(zPOS-zSpeed,1300,-500)||inPillarZ(xPOS,zPOS-zSpeed,192)){
       }else{
       zPOS-=zSpeed;
       }
   }
   calcSpeeds(((ANGLE+90.0)%360.0),5.0);
   if(Atrue == true){
       if(outOfBoundsX(xPOS+xSpeed,1300,-500)||inPillarX(xPOS+xSpeed,zPOS,192)){
       }else{
       xPOS+=xSpeed;
       }
       if(outOfBoundsZ(zPOS+zSpeed,1300,-500)||inPillarZ(xPOS,zPOS+zSpeed,192)){
       }else{
       zPOS+=zSpeed;
       }
   }
   if(Dtrue == true){
       if(outOfBoundsX(xPOS-xSpeed,1300,-500)||inPillarX(xPOS-xSpeed,zPOS,192)){
       }else{
       xPOS-=xSpeed;
       }
       if(outOfBoundsZ(zPOS-zSpeed,1300,-500)||inPillarZ(xPOS,zPOS-zSpeed,192)){
       }else{
       zPOS-=zSpeed;
       }
   }
}

void keyPressed(){
   if (startScreen){
       if (key== ' '){
           ShootTrue = true;
       } else if (key == 'r'){
           ammo = 50;
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
   if (key== ' '){
       ShootTrue = false;
   }
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


boolean outOfBoundsX(float x, float MAX, float MIN){
   return (((x)>=MAX)||((x)<=MIN));
}


boolean outOfBoundsZ(float z, float MAX, float MIN){
   return (((z)>=MAX)||((z)<=MIN));
}


boolean inPillarX(float x, float z, float range){
  return (((((x)>=(pillarCoordX[0]-range))&&(x)<=(pillarCoordX[0]+range))&&((((z>=(pillarCoordZ[0]-range))&&(z<=(pillarCoordZ[0]+range))))||(((z)>=(pillarCoordZ[1]-range))&&((z)<=(pillarCoordZ[1]+range)))))||((((x)>=(pillarCoordX[2]-range))&&(x)<=(pillarCoordX[2]+range))&&((((z>=(pillarCoordZ[3]-range))&&(z<=(pillarCoordZ[3]+range))))||(((z)>=(pillarCoordZ[2]-range))&&((z)<=(pillarCoordZ[2]+range))))));
}


boolean inPillarZ(float x, float z, float range){
  return (((((z)>=(pillarCoordZ[0]-range))&&(z)<=(pillarCoordZ[0]+range))&&((((x>=(pillarCoordX[0]-range))&&(x<=(pillarCoordX[0]+range))))||(((x)>=(pillarCoordX[3]-range))&&((x)<=(pillarCoordX[3]+range)))))||((((z)>=(pillarCoordZ[2]-range))&&(z)<=(pillarCoordZ[2]+range))&&((((x>=(pillarCoordX[1]-range))&&(x<=(pillarCoordX[1]+range))))||(((x)>=(pillarCoordX[2]-range))&&((x)<=(pillarCoordX[2]+range))))));
}


  

void calcSpeeds(float ANGLE, float Speed){
   xANGLE =(sin((ANGLE)*PI/180.0));
   zANGLE =(cos((ANGLE)*PI/180.0));
   xSpeed = (Speed*xANGLE);
   zSpeed = (Speed*zANGLE);
}



