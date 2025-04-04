int ammo = 32;
int health = 100;
int numEnemies = 3;
boolean gameEnd = false;
boolean startScreen = true;
//PVector
PMatrix3D baseMat;
int pillarCoordX[] = {0,0,800,800};
int pillarCoordZ[] = {0,800,800,0};
int enemyCoordX[] = {200,500,500,200};
int enemyCoordZ[] = {200,200,500,500};
//int cameraCoord[] = {0,0,0};
float zPOS = 0;
float xPOS = 0;
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


void setup () {
    size (1200, 780, P3D);
    xPOS = 0;
    zPOS = height/2;
    baseMat = getMatrix(baseMat);
}

void makeEnemy (int xPos, int zPos){
    fill (255, 0, 0);
    translate (xPos, height/2+25, zPos);
    box (50, 150, 50);
    translate(-xPos, -(height/2+25), -zPos);
}

void makeEnemies (){
    for (int i=0; i<3; i++){
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
        translate(400, height/2, 400);
        box(2000, 200, 2000);
        translate(-400, -(height/2), -400);
        for(int i = 0; i<4; i++){
        translate(pillarCoordX[i], height/2, pillarCoordZ[i]);
        box(200);
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
        xPOS+=xSpeed;
        zPOS+=zSpeed;
    }
    if(Strue == true){
        xPOS-=xSpeed;
        zPOS-=zSpeed;
    }
    ANGLE=(ANGLE+90.0)%360.0;
    xANGLE =(sin((ANGLE)*PI/180.0));
    zANGLE =(cos((ANGLE)*PI/180.0));
    xSpeed = (5.0*xANGLE);
    zSpeed = (5.0*zANGLE);
    if(Atrue == true){
        xPOS+=xSpeed;
        zPOS+=zSpeed;
    }
    if(Dtrue == true){
        xPOS-=xSpeed;
        zPOS-=zSpeed;
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
