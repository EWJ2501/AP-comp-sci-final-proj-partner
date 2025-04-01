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
int zANGLE = 0;
int yANGLE = height/2;
int xANGLE = 0;
boolean Wtrue = false;
boolean Atrue = false;
boolean Strue = false;
boolean Dtrue = false;
boolean turnLeft = false;
boolean turnRight = false;
float yRotation = 0.0;



void setup () {
    size (1200, 800, P3D);
    xPOS = 0;
}



void draw () {
    if (startScreen){
        background(0);
        lights();
        movement();
        spotLight(255, 255, 255, xPOS, height/2, zPOS, 0, 0, -1, PI/4, 2);
        camera(xPOS, height/2, zPOS/tan(PI/6), xPOS, height/2, 0+zPOS, 0, 1, 0);
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
    if(Wtrue == true){
        zPOS-=5;
    }
    if(Atrue == true){
        xPOS-=5;
    }
    if(Strue == true){
        zPOS+=5;
    }
    if(Dtrue == true){
        xPOS+=5;
    }
    if(turnLeft == true){
        
    }
    if(turnRight == true){
        
    }
    
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
