int plyrpos1 = 0;
int plyrpos2 = 25;
int plyrspd = 2;
int lnchbar = 490;
int lnchbarspd = 0;
float holepos1 = 0;
float holepos2 = 0;
float pwr = 0;
float[][] ballstats = new float [10][4];
int ballnum = 0;
float friction = 0.99;
float[][] fieldcols = new float [20][10];
boolean lnch = false;
boolean go = false;
boolean win = false;
boolean lose = false;

void setup() {
  size(1280, 960);
  holepos1 = random(100, 1000); 
  holepos2 = random(100, 500);
  for(int i=0; i < fieldcols.length; i++) {
    for(int j=0; j < fieldcols[i].length; j++) {
      fieldcols[i][j] = random(100, 200); 
    }
  }
  for(int i=0; i<ballstats.length; i++) {
    ballstats[i][0] = -700;
  }
}

void draw() {
 rectMode(CORNERS);
 noStroke();
 fill(100);
 rect(0, 640, 1280, 1280);
 field(fieldcols);
 fill(0); 
 ellipse(holepos1, holepos2, 100, 100);
 drawPlayer(plyrpos1, plyrpos2);
 plyrpos1 = plyrpos1 + plyrspd;
 plyrpos2 = plyrpos2 + plyrspd;


 if (plyrpos1 >= 1230) 
  plyrspd = -1*plyrspd;
  
 if (plyrpos1 <= -50)
 plyrspd = -1*plyrspd;
 
if(lnch==true) {
   fill(255, 0, 0);
   rect(25, lnchbar, 75, 490);
   lnchbar = lnchbar - lnchbarspd;
}

 pwr = pwr + lnchbarspd;
 
 for(int i=0; i<ballstats.length; i++) {
   drawBall(ballstats[i][0], ballstats[i][1]); 
 }
 
 if (lnchbar <= 250) 
  lnchbarspd = 0;
  
  if (go==true) {
    ballstats[ballnum][0] = plyrpos1+50;
    ballstats[ballnum][1] = ballstats[ballnum][1] - ballstats[ballnum][2];
    ballstats[ballnum][2] = ballstats[ballnum][2]*friction;
    ballstats[ballnum][3] = dist(ballstats[ballnum][0], ballstats[ballnum][1], holepos1, holepos2);
    if (ballstats[ballnum][2] <= 0.05) {
      if (ballstats[ballnum][3] <= 25) {
        win=true;
      }
      else {
        lnch=false;
        go=false; 
        lnchbar=490; 
        plyrspd=2;
        if(ballnum<=8){
        ballnum++;
        }
        else if(ballnum>=9) {
          lose=true;
          plyrspd=0;
        }
      }   
    }
   if (ballstats[ballnum][1] <= pwr) 
   ballstats[ballnum][2] = 0;
  }
  
  if(lose==true) {
  fill(255, 204, 153);
  ellipse(640, 480, 750, 750);
  fill(0, 150, 255); 
  rect(450, 350, 550, 600); 
  rect(730, 350, 830, 600); 
  fill(255); 
  ellipse(500, 350, 200, 100); 
  ellipse(780, 350, 200, 100); 
  fill(0);
  ellipse(500, 350, 100, 100); 
  ellipse(780, 350, 100, 100); 
  arc(640, 700, 200, 200, PI, TWO_PI, CHORD); 
  }
  
  if(win==true) {
    lnchbar=490;
    if(ballnum==0) {
      drawTrophy(255, 191, 0);
    }
    else if(ballnum==1) {
      drawTrophy(192, 192, 192);
    }
    else if(ballnum>=2) {
      drawTrophy(102, 163, 255);
    }
  }
}

void keyPressed() {
  if (lnch==false) {
  plyrspd=0;
  lnchbar=490;
  lnchbarspd=1;
  pwr=0;
  lnch=true;
  }
  else if (lnch==true) {
  lnchbarspd=0;
  ballstats[ballnum][1]=700;
  go=true;
  pwr=pwr*-35/12;
  ballstats[ballnum][2] = -pwr/100;
  }
}

void field(float[][] arr) {
  for(int i=0; i < arr.length; i++) {
    for(int j=0; j < arr[i].length; j++) {
      fill(0, arr[i][j], 0); 
      rect(64*i, 64*j, 64*i+64, 64*j+64); 
    }
  }
}

void drawBall(float x, float y) {
  fill(255);
  ellipse(x, y, 50, 50);
}

void drawPlayer(float x, float y) {
  fill(255, 200, 0);
 triangle(x, 775, x+50, 700, x+100, 775);
 rect(y, 775, y+50, 900);
}

void drawTrophy(int x, int y, int z) {
  fill(x, y, z);
  rect(610, 450, 670, 700);
  rect(400, 250, 600, 300);
  rect(680, 250, 880, 300);
  arc(640, 300, 480, 350, 0, PI, CHORD);
  fill(0, 200, 0);
  arc(640, 300, 400, 300, 0, PI, CHORD);
  fill(x, y, z);
  arc(640, 200, 300, 600, 0, PI, CHORD);
  arc(640, 750, 200, 200, PI, TWO_PI, CHORD);
}
