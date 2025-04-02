int ammo = 32;
int health = 100;
int numEnemies = 3;
boolean gameEnd = false;
boolean startScreen = true;
//PVector

int pillarCoordX[] = {0,0,800,800};
int pillarCoordZ[] = {0,800,800,0};
//int cameraCoord[] = {0,0,0};
int zPOS = 0;
int xPOS = 0;
int zVector = 0;
int xVector = 0;
float xANGLE = 0;
float zANGLE = 0;
int ANGLE = 180;
float fraction = 0.0;
int xSpeed = 5;
int zSpeed = 5;
boolean Wtrue = false;
boolean Atrue = false;
boolean Strue = false;
boolean Dtrue = false;
boolean turnLeft = false;
boolean turnRight = false;
float yRotation = 0.0;
int vector = 170;


void setup () {
    size (1200, 800, P3D);
    xPOS = 0;
    zPOS = height/2;
}



void draw () {
    if (startScreen){
        background(0);
        lights();
        movement();
        spotLight(0, 0, 0, 400, height/2, 400, 0, 0, -1, PI/4, 2);
        spotLight(255, 255, 255, xPOS, height/2, zPOS, 0, 0, -1, PI/4, 2);
        camera(xPOS, height/2, zPOS/tan(PI/6), xPOS+xVector, height/2, zPOS+zVector, 0, 1, 0);
        translate(400, height/2, 400);
        box(2000, 200, 2000);
        translate(-400, -(height/2), -400);
        for(int i = 0; i<4; i++){
        translate(pillarCoordX[i], height/2, pillarCoordZ[i]);
        box(200);
        translate(-pillarCoordX[i],-(height/2),-pillarCoordZ[i]);
        }
        stroke(255);
    } else if (!startScreen && ! gameEnd){

    } else if (gameEnd){

    }
    

}


void movement(){
    //fraction = (zANGLE/xANGLE);
    //ANGLE = atan(fraction);
    if(turnLeft == true){
        ANGLE=(ANGLE+1)%360;
    }
    if(turnRight == true){
        ANGLE=(ANGLE-1)%360;
    }
    println("degree",ANGLE);
    xANGLE =(sin((ANGLE)*PI/180));
    zANGLE =(cos((ANGLE)*PI/180));
    xSpeed = round(5*xANGLE);
    zSpeed = round(5*zANGLE);
    xVector = round(10000*xANGLE);
    zVector = round(10000*zANGLE);
    println("sin: ",xANGLE);
    println("cos: ",xANGLE);
    println("x: ",xSpeed);
    println("z: ",zSpeed);
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
    ANGLE=(ANGLE+90)%360;
    xANGLE =(sin((ANGLE)*PI/180));
    zANGLE =(cos((ANGLE)*PI/180));
    xSpeed = round(5*xANGLE);
    zSpeed = round(5*zANGLE);
    if(Atrue == true){
        xPOS+=xSpeed;
        zPOS+=zSpeed;
    }
    if(Dtrue == true){
        xPOS-=xSpeed;
        zPOS-=zSpeed;
    }
    ANGLE=(ANGLE-90)%360;
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
