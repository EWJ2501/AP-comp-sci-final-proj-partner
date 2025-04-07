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
int boundingBoxCoordY[] = {0,0,200,-200,0,0};
int boundingBoxCoordZ[] = {0,0,0,0,2000,-2000};
PShape pillar;
PImage pillarTex;
PShape boundingBox;
PImage flooringTex;

void setup () {
    size (1200, 780, P3D);
    xPOS = 0;
    zPOS = height/2;
    pillarTex = loadImage("irongrate.jpg");
    pillar = createShape(BOX,200);
    flooringTex = loadImage("metalfloor.jpg");
    boundingBox = createShape(BOX,2000,200,2000);
    boundingBox.setTexture(flooringTex);
    pillar.setTexture(pillarTex);
    noFill();
}

void makeEnemy (int xPos, int zPos){
    fill (255, 0, 0);
    translate (xPos, height/2+25, zPos);
    box (65, 150, 65);
    translate(-xPos, -(height/2+25), -zPos);
}

void makeEnemies (){
    for (int i=0; i<4; i++){
        makeEnemy(enemyCoordX[i], enemyCoordZ[i]);
    }
    fill (100);
}

void draw () {
    if (startScreen){
        background(0);
        lights();
        movement();
        ambientLight(0, 0, 0);
        spotLight(220,220,220,xPOS, height/2, zPOS,xPOS+xVector, height/2, zPOS+zVector, PI/3, 1);
        camera(xPOS, height/2, zPOS, xPOS+xVector, height/2, zPOS+zVector, 0, 1, 0);
        for(int i = 0; i<6; i++){
        translate(400, (height/2), 400);
        translate(boundingBoxCoordX[i],boundingBoxCoordY[i],boundingBoxCoordZ[i]);
        shape(boundingBox);
        translate(-boundingBoxCoordX[i],-boundingBoxCoordY[i],-boundingBoxCoordZ[i]);
        translate(-400, -(height/2), -400);
        }
        for(int i = 0; i<4; i++){
        translate(pillarCoordX[i], height/2, pillarCoordZ[i]);
        shape(pillar);
        translate(-pillarCoordX[i],-(height/2),-pillarCoordZ[i]);
        }
        // translate((xPOS+(30.0*xANGLE)), height/2, (zPOS+(30.0*zANGLE)));
        // box(20);
        // translate(-(xPOS+(30.0*xANGLE)), -height/2, -(zPOS+(30.0*zANGLE)));
        stroke(255);
        makeEnemies();
    } else if (!startScreen && ! gameEnd){

    } else if (gameEnd){

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
    println("degree",ANGLE);
    xANGLE =(sin(ANGLE*PI/180.0));
    zANGLE =(cos(ANGLE*PI/180.0));
    xSpeed = (5.0*xANGLE);
    zSpeed = (5.0*zANGLE);
    xVector = (10000*xANGLE);
    zVector = (10000*zANGLE);
    println("xSpeed: ",xSpeed);
    println("zSpeed: ",zSpeed);
    println("XPos: ",xPOS);
    println("ZPos: ",zPOS);
    println("zVector: ",zVector);
    println("xVector: ",xVector);
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
