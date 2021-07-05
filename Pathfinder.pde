Population p;
int targetsSide = 50;
PVector unitsTarget;
int gen = 0;

void displayTarget(){
  noStroke();
  fill(0, 255, 0);
  rect(unitsTarget.x, unitsTarget.y, targetsSide, targetsSide);
}

void setup() {
  size(800, 1600);
  unitsTarget = new PVector(width/2-targetsSide/2, 0);
  p = new Population();
}

void draw() {
  background(255);
  displayTarget();
  if(!p.allDead()){
    p.run();
  } else{
    p = p.reproduce();
    gen++;
  }
  
  textSize(20);
  fill(0);
  //text("Alive: "+p.countAlive(), 100, 100);
  text("Generation: "+gen, 100, 100);
}


/*int pickParent(float[] probs) {
 float r = random(1);
 int currentIndex = -1;
 while (r > 0) {
 currentIndex++;
 r -= probs[currentIndex];
 }
 return currentIndex;
 }
 
 float[] probs = {0.3, 0.2, 0.5};
 int c0=0, c1=0, c2=0;
 float c=0;
 void setup() {
 size(800, 1600);
 }
 
 void draw() {
 background (0);
 int x = pickParent(probs);
 switch(x) {
 case 0:
 c0++;
 break;
 case 1:
 c1++;
 break;
 case 2:
 c2++;
 break;
 }
 c++;
 textSize(30);
 text(c0/c, width/2, 100);
 text(c1/c, width/2, 400);
 text(c2/c, width/2, 700);
 }*/