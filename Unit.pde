class Unit{
  
  DNA dna;
  PVector pos, speed,force;
  float currentGene = 0;
  boolean dead = false;
  int spawnTime, deathTime;
  float fitness, probability;
  
  PVector target = unitsTarget;
  
  Unit(int length){
    dna = new DNA(length);
    pos = new PVector(width/2, height);
    speed = new PVector(0, 0);
    force = new PVector(0, 0);
    spawnTime = millis();
  }
  
  Unit(Unit mother, Unit father){
    dna = new DNA(mother.dna.genes.length);
    pos = new PVector(width/2, height);
    speed = new PVector(0, 0);
    force = new PVector(0, 0);
    spawnTime = millis();
    for(int i = 0; i < mother.dna.genes.length; i++){
      if(i%2==0){
        this.dna.genes[i] = mother.dna.genes[i];
      } else{
        this.dna.genes[i] = father.dna.genes[i];
      }
    }
  }
  
  void display(){
    stroke(0);
    fill(0);
    ellipse(pos.x, pos.y, 10, 10);
  }
  
  void update(){
    pos.add(speed);
    speed.add(force);
    force.mult(0);
    force.add(dna.genes[floor(currentGene)]);
  }
  
  void checkEdges(){
    boolean dead = false;
    if(pos.x < 0){
      dead = true;
      pos.x = 0;
    }
    if(pos.x > width){
      dead = true;
      pos.x = width;
    }
    if(pos.y < 0){
      dead = true;
      pos.y = 0;
    }
    if(pos.y > height){
      dead = true;
      pos.y = height;
    }
    this.dead = dead;
  }
  
  void checkTarget(){
    if(pos.x > target.x && pos.x < target.x + targetsSide){
      if(pos.y > target.y && pos.y < target.y + targetsSide){
        dead = true;
        deathTime = millis();
      }
    }
  }
  
  
  void run(){
    if(!this.dead) {
      this.update();
      this.checkEdges();
      this.checkTarget();
      currentGene += 0.1;
    }
    this.display();
    if(currentGene >= dna.genes.length){
      this.dead = true;
      deathTime = millis();
    }
  }
  
  void calcFitness(){
    float distance = dist(pos.x, pos.y, target.x, target.y)+0.1;
    //int lifeTimeSeconds = (deathTime - spawnTime) / 1000;
    
    fitness = 1/distance;
  }
  
  void mutate(float rate){
    this.dna.mutate(rate);
  }
}