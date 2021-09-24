Population p;
int targetsSide = 50;
PVector unitsTarget;
int gen = 0;
float averageFitness = 0;

void displayTarget(){
  noStroke();
  fill(0, 255, 0);
  rect(unitsTarget.x, unitsTarget.y, targetsSide, targetsSide);
}

void displayNewObstacle(){
  noStroke();
  fill(0, 0, 50, 50);
  rect(x, y, w, h);
}

void setup() {
  size(1200, 600);
  unitsTarget = new PVector(width-targetsSide, height/2-targetsSide/2);
  p = new Population(new ArrayList<Obstacle>());
}

void draw() {
  background(255);
  displayTarget();
  if(drawing) displayNewObstacle();
  if(!p.allDead()){
    p.run();
  } else{
    p.calcFitnesses();
    p.normalizeFitnesses();
    averageFitness = p.getAverageFitness();
    p = p.reproduce();
    gen++;
  }
  
  textSize(20);
  fill(0);
  text("Generation: "+gen, 10, 50);
  text("Average fitness: "+averageFitness, 10, 100);
}


boolean drawing = false;
int x = 0, y = 0;
int w = 0, h = 0;

void mousePressed(){
  if(!drawing){
    drawing = true;
    x = mouseX;
    y = mouseY;
  }
}

void mouseDragged(){
  if(drawing){
    w = mouseX - x;
    h = mouseY - y;
  }
}

void mouseReleased(){
  if(drawing && w != 0 && h != 0){
    if(w < 0){
      w *= -1;
      x -= w;
    }
    if(h < 0){
      h *= -1;
      y -= h;
    }
    p.obstacles.add(new Obstacle(x, y, w, h));
  } 
  drawing = false;
  w = 0;
  h = 0;
}
