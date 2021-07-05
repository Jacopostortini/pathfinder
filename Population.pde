class Population{
  
  int size = 200;
  int dnaLength = 100;
  Unit[] units;
  
  Population(){
    units = new Unit[size];
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
  
  void run(){
    for(Unit u: units){
      u.run();
    }
  }
  
  Population reproduce(){
    Population population = new Population();
    normalizeFitnesses();
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
      u.calcFitness();
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