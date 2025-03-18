int ammo = 32;
int health = 100;
int numEnemies = 3;
boolean gameEnd = false;
boolean startScreen = true;

void setup () {
    size (2560, 1600);
}

void draw () {
    if (startScreen){
        background (100);
        rectMode(CENTER);
        strokeWeight(3);
        rect (2560/2, 1600/2, 400, 150);
        strokeWeight(1);
        fill (255);
    } else if (!startScreen && ! gameEnd){

    } else if (gameEnd){

    }

}