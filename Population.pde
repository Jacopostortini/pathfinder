class Population{
  
  int size = 200;
  int dnaLength = 50;
  Unit[] units;
  ArrayList<Obstacle> obstacles;
  
  Population(ArrayList<Obstacle> obstacles){
    units = new Unit[size];
    this.obstacles = obstacles;
    for(int i = 0; i < units.length; i++){
      units[i] = new Unit(dnaLength);
    }
  }
  
  boolean allDead(){
    return countAlive() == 0;
  }
  
  int countAlive(){
    int n = 0;
    for(Unit u: units){
      if(!u.dead) n++;
    }
    return n;
  }
  
  float getAverageFitness(){
    float sum = 0;
    for(Unit u: units){
      sum += u.fitness;
    }
    return sum / units.length;
  }
  
  void run(){
    for(Unit u: units){
      u.run(obstacles);
    }
    for(Obstacle ob: obstacles){
      ob.display();
    }
  }
  
  void calcFitnesses(){
    for(Unit u: units){
      if(u.deathTime == 0) u.deathTime = millis();
      u.calcFitness();
    }
  }
  
  Population reproduce(){
    Population population = new Population(obstacles);
    for(int i = 0; i < population.size; i++){
      Unit mother = pickParent();
      Unit father = pickParent();
      population.units[i] = new Unit(mother, father);
      population.units[i].mutate(0.01);
    }
    return population;
  }
  
  void normalizeFitnesses(){
    float sum = 0;
    for(Unit u: units){
      sum += u.fitness;
    }
    
    for(Unit u: units){
      u.probability = u.fitness / sum;
    }
  }
  
  Unit pickParent(){
    float r = random(1);
    int currentIndex = -1;
    while(r > 0) {
      currentIndex++;
      r -= units[currentIndex].probability;
    }
    return units[currentIndex];
  }
}
