int ammo = 32;
int health = 100;
int numEnemies = 3;
boolean gameEnd = false;
boolean startScreen = true;

int pillarCoordX[] = {0,0,0,0};
int pillarCoordZ[] = {0,0,0,0};
int z = -100;
int x = 0;
int y = 0;
boolean Wtrue = false;
boolean Atrue = false;
boolean Strue = false;
boolean Dtrue = false;
float yRotation = 0.0;



void setup () {
    size (1200, 800, P3D);
}



void draw () {
    if (startScreen){
        background(0);
        lights();
        spotLight(255, 0, 0, width/2, height/2, 400, 0, 0, -1, PI/4, 2);
        movement();
         //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
        rotateY(yRotation);
        for(int i = 0; i<4; i++{
        translate(x, height/2, z);
        box(200);
        })
        stroke(255);
        yRotation = yRotation + 0.01;
    } else if (!startScreen && ! gameEnd){

    } else if (gameEnd){

    }
    

}


void movement(){
    if(Wtrue == true){
        z+=5;
    }
    if(Atrue == true){
        x-=5;
    }
    if(Strue == true){
        z-=5;
    }
    if(Dtrue == true){
        x+=5;
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
}
