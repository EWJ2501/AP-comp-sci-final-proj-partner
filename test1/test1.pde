int ammo = 32;
int health = 100;
int numEnemies = 3;
boolean gameEnd = false;
boolean startScreen = false;

void setup () {
    size (1440, 780);
}



void draw () {
    if (startScreen){
        background (100);
        // start button
        rectMode(CENTER);
        strokeWeight(3);
        fill (255);
        rect (1440/2, 600, 200, 80);

        textAlign(CENTER);
        fill(0);
        textSize(50);
        text ("PLAY", 720, 620);

    } else if (!startScreen && ! gameEnd){
        // UI
        fill(255);
        rectMode (CORNER);
        strokeWeight (10);
        rect (0, 600, 1440, 180);

        // health
        rectMode (CENTER);
        fill (100);
        rect (720, 690, 300,180);
        textAlign (CENTER);
        textSize (50);
        fill (0);
        text ("HEALTH", 720, 660);

        // ammo
        text ("AMMO", 150, 660);
        textSize(70);
        text (ammo + "/32", 150, 740);

    } else if (gameEnd){
        
    }

}

void mouseClicked () {
    if (startScreen){
        if (mouseX>620 && mouseX<820 && mouseY>520 && mouseY<680){
            startScreen = false;
        }
    } else if (!startScreen && ! gameEnd){

    } else if (gameEnd){
        gameEnd = false;
    }
}

void keyPressed (){
    if (!startScreen && !gameEnd){
        if (key== ' '){
            
        }
    }
}