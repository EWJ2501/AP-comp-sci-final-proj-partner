int ammo = 32;
int health = 100;
int numEnemies = 3;
boolean gameEnd = false;
boolean startScreen = true;

void setup () {
    size (1440, 780);
}

void draw () {
    if (startScreen){
        background (100);
        // start button
        rectMode(CENTER);
        strokeWeight(3);
        rect (1440/2, 780/2, 400, 150);
        strokeWeight(1);
        fill (255);

    } else if (!startScreen && ! gameEnd){
        // UI
        rectMode (CORNER);


    } else if (gameEnd){

    }

}

void mouseClicked () {

}