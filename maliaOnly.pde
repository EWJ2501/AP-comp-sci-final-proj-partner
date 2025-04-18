int ammo = 50;
int health = 100;
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


void UI(){
       UIlayer.translate(600,760);
       UIlayer.rectMode(CENTER);
       UIlayer.noFill();
       UIlayer.textFont(techyFont);

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


void keyPressed(){
   if (!startScreen && !gameEnd){
       if (key== ' '){
           ShootTrue = true;
       } else if (key == 'r'){
           ammo = 50;
       }
       
   } else if (startScreen){
       startScreen = false;
   } else if (gameEnd){
       gameReset();
   }
}
