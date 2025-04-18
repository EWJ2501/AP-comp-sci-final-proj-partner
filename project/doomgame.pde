 
int ammo = 50;
int health = 100;
int numEnemies = 3;
boolean gameEnd = false;
boolean startScreen = true;
PMatrix3D baseMat;
int pillarCoordX[] = {0,0,805,805};
int pillarCoordZ[] = {0,805,805,0};
int enemyCoordX[] = {-420,940,800,0};
int enemyCoordZ[] = {-500,60,640,1200};
int enemyHealth[] = {10,10,10,10};
int currentEnemy = 0;
int time2;
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
float UIX = 0;
float UIZ = 0;
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
int coolDown = 125;
int time;
ArrayList<Float> bulletX = new ArrayList<>(); // Create an Array
ArrayList<Float> bulletZ = new ArrayList<>(); // Create an Array
ArrayList<Float> bulletXVector = new ArrayList<>(); // Create an Array
ArrayList<Float> bulletZVector = new ArrayList<>(); // Create an Array
ArrayList<Float> bulletYangle = new ArrayList<>(); // Create an Array
ArrayList<Integer> removeBullet = new ArrayList<>(); // Create an Array

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
   time2 = millis();
}

void makeEnemy (int currentEnemy){
    if (currentEnemy <4 && currentEnemy >=0){
        World.fill (255, 0, 0);
        World.translate (enemyCoordX[currentEnemy], height/2+25, enemyCoordZ[currentEnemy]);
        World.box (65, 150, 65);
        World.fill(255,255,255);
        World.translate(-enemyCoordX[currentEnemy], -(height/2+25), -enemyCoordZ[currentEnemy]);
    } 
}

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

void detectHit (int e){
    if (bulletX.size()>0){
        for (int i = 0; i<bulletX.size(); i++){
            if (bulletX.get(i) > enemyCoordX[e]-35  && bulletX.get(i) < enemyCoordX[e]+35 && bulletZ.get(i) > enemyCoordZ[e]-35  && bulletZ.get(i) < enemyCoordZ[e]+35){
                enemyHealth[e] -= 1;
                bulletX.remove(i);
                bulletZ.remove(i);
                bulletXVector.remove(i);
                bulletZVector.remove(i);
                bulletYangle.remove(i);
                if (enemyHealth[e] == 0){
                    currentEnemy+=1;
                }
            }
        }
    }
}

void detectCDmg (){
    if (health != 0 && xPOS > enemyCoordX[currentEnemy]-300  && xPOS < enemyCoordX[currentEnemy]+300 && zPOS > enemyCoordZ[currentEnemy]-300  && zPOS < enemyCoordZ[currentEnemy]+300){
        if (millis()-time2>= 500){
            time2 = millis();
            health -= 5;
            if (health<=0){
                gameEnd = true;
            }
        }
    }
}

void appendBulletCoords(int i){
for(int bulletID = 0; bulletID<i; bulletID++){
   if(!(((outOfBoundsX(bulletX.get(bulletID),1395,-595))||(inPillarX(bulletX.get(bulletID),bulletZ.get(bulletID),105)||((outOfBoundsZ(bulletZ.get(bulletID),1395,-595))||(inPillarZ(bulletZ.get(bulletID),bulletX.get(bulletID),105))))))){
       bulletX.set(bulletID, bulletX.get(bulletID) + bulletXVector.get(bulletID));
       bulletZ.set(bulletID, bulletZ.get(bulletID) + bulletZVector.get(bulletID));
       World.translate (bulletX.get(bulletID), ((height/2)+50), bulletZ.get(bulletID));
       World.rotateY(bulletYangle.get(bulletID)*PI/180);
       World.shape(bullet1);
       World.rotateY(-(bulletYangle.get(bulletID)*PI/180));
       World.translate (-bulletX.get(bulletID), -((height/2)+50), -bulletZ.get(bulletID));
   }else{
     removeBullet.add(bulletID);
   }
}
   for(int s = 0; s<removeBullet.size(); s++){
    bulletX.remove(removeBullet.get(s));
    bulletZ.remove(removeBullet.get(s));
    bulletXVector.remove(removeBullet.get(s));
    bulletZVector.remove(removeBullet.get(s));
    bulletYangle.remove(removeBullet.get(s));
   }
}


void gameReset(){
    gameEnd = false;
    ammo = 50;
    health = 100;
    currentEnemy = 0;
    xPOS = 400;
    zPOS = 400;
    zVector = 0;
    xVector = 0;
    xANGLE = 0;
    zANGLE = 0;
    ANGLE = 180;
    for(int i=0; i<4; i++){
       enemyHealth[i] = 10;
    }
}


void draw () {
   if (startScreen){
       UIlayer.beginDraw();
       background(0);
       UIlayer.textAlign (CENTER);
       UIlayer.textSize (100);
       UIlayer.fill(255,0,0);
       UIlayer.text("PRESS ANY KEY TO START", width/2, height-100);
       UIlayer.fill(255,255,0);
       UIlayer.textSize (70);
       UIlayer.text("MOVEMENT: W, A, S, D", width/2, height-400);
       UIlayer.text("CAMERA: J, K", width/2, height-300);
       UIlayer.text("SHOOT: SPACE", width/2, height-200);
       UIlayer.endDraw();
       image(UIlayer, 0, 0);


   } else if (!startScreen && ! gameEnd){
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
       
       if(bulletX.size()>0){
          appendBulletCoords(bulletX.size());
       }
       if (currentEnemy<4){
         makeEnemy(currentEnemy);
       }
       if (currentEnemy<4){
        detectHit(currentEnemy);
       }
       if (currentEnemy<4){
        detectCDmg();
       }
       else {
        gameEnd = true;
       }
       World.endDraw();

       UIlayer.beginDraw();
       UIlayer.clear();
       UI();
       UIlayer.endDraw();
       image(World, 0, 0);
       image(UIlayer, 0, 0);

   } else if (gameEnd){
       UIlayer.beginDraw();
       UIlayer.background(0);
       UIlayer.textSize(120);
       UIlayer.textAlign(CENTER);
       if (health==0){
          UIlayer.text("YOU LOST", width/2, height/2-100);
          UIlayer.textSize(50);
          UIlayer.text("PRESS ANY KEY TO TRY AGAIN", width/2, height/2+150);
       } else if (currentEnemy==4){
          UIlayer.text("YOU WON", width/2, height/2-100);
          UIlayer.textSize(50);
          UIlayer.text("PRESS ANY KEY TO PLAY AGAIN", width/2, height/2+150);
       }
       UIlayer.endDraw();
       image(UIlayer, 0, 0);
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
       UIlayer.translate(-600,-760);
       if(Wtrue== true||Atrue== true||Strue== true||Dtrue== true){
           walkVal = walkVal + updown;
           if (walkVal>=10){
               updown = -1;
           }
           if (walkVal<=-10){
               updown = 1;
           }
       }
       UIlayer.image(gun,-400,-(300+walkVal));


       UIlayer.rectMode (CORNER);
       UIlayer.strokeWeight (10);
       UIlayer.rect(0, 600, 1200, 180);

       // health
       UIlayer.rectMode (CENTER);
       UIlayer.fill (255);
       UIlayer.strokeWeight (1);
       UIlayer.rect (width/2, 720, 200, 30);

        if (health > 50){
            UIlayer.fill(0,200,0);
        } else if (health <= 50 && health >= 30){
            UIlayer.fill(255,255,0);
        } else if (health < 30){
            UIlayer.fill(200,0,0);
        }
       
       UIlayer.rectMode (CORNER);
       UIlayer.rect (width/2-96, 709, 192*(health/100.0), 22);
       UIlayer.strokeWeight (10);
       UIlayer.noFill();
       UIlayer.rectMode (CENTER);


       UIlayer.rect (width/2, 690, 300, 180);
       UIlayer.textAlign (CENTER);
       UIlayer.textSize (32);
       UIlayer.fill (255);
       UIlayer.text ("HEALTH", width/2, 660);


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
   if (!startScreen && !gameEnd){
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
   } else if (startScreen){
       startScreen = false;
   } else if (gameEnd){
       gameReset();
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