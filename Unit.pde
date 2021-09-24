class Unit {

  DNA dna;
  PVector pos, speed, force;
  float currentGene = 0;
  boolean dead = false;
  int spawnTime, deathTime = 0;
  float fitness, probability;

  PVector target = unitsTarget;

  Unit(int length) {
    dna = new DNA(length);
    pos = new PVector(0, height/2);
    speed = new PVector(0, 0);
    force = new PVector(0, 0);
    spawnTime = millis();
  }

  Unit(Unit mother, Unit father) {
    Unit newUnit = new Unit(mother.dna.genes.length);
    this.dna = newUnit.dna;
    this.pos = newUnit.pos;
    this.speed = newUnit.speed;
    this.force = newUnit.force;
    this.spawnTime = newUnit.spawnTime;

    for (int i = 0; i < mother.dna.genes.length; i++) {
      if (i%2==0) {
        this.dna.genes[i] = mother.dna.genes[i];
      } else {
        this.dna.genes[i] = father.dna.genes[i];
      }
    }
  }

  void display() {
    stroke(0);
    fill(0);
    ellipse(pos.x, pos.y, 10, 10);
  }

  void update() {
    pos.add(speed);
    speed.add(force);
    force = dna.genes[floor(currentGene)];
  }

  void checkEdges() {
    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      dead = true;
    }
  }
  
  void checkObstacle(Obstacle ob){
    if (pos.x > ob.x && pos.x < ob.x+ob.w && pos.y > ob.y && pos.y < ob.y+ob.h) {
      dead = true;
    }  
  }

  void checkTarget() {
    if (pos.x > target.x && pos.x < target.x + targetsSide) {
      if (pos.y > target.y && pos.y < target.y + targetsSide) {
        dead = true;
        deathTime = millis();
      }
    }
  }


  void run(ArrayList<Obstacle> obstacles) {
    if (!this.dead) {
      this.update();
      this.checkEdges();
      for(Obstacle ob: obstacles){
        this.checkObstacle(ob);      
      }
      this.checkTarget();
      currentGene += 0.2;
    }
    this.display();
    if (currentGene >= dna.genes.length) {
      this.dead = true;
      deathTime = millis();
    }
  }

  void calcFitness() {
    float distance = dist(pos.x, pos.y, target.x, target.y)+0.1;
    float lifetime = (deathTime - spawnTime) / 1000.0 ;
    fitness = 1/(pow(distance, 1)*pow(lifetime, 3));
  }

  void mutate(float rate) {
    this.dna.mutate(rate);
  }
}
