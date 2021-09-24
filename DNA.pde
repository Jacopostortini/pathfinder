class DNA {

  PVector[] genes;
  float forceMag = 1;
  DNA(int length) {
    genes = new PVector[length];
    for (int i = 0; i < genes.length; i++) {
      float angle = random(-PI, PI);
      genes[i] = new PVector(forceMag*cos(angle), forceMag*sin(angle));
    }
  }

  void mutate(float rate) {
    for (int i = 0; i < genes.length; i++) {
      float r = random(1);
      if (r<rate) {
        float angle = random(-PI, PI);
        genes[i] = new PVector(forceMag*cos(angle), forceMag*sin(angle));
      }
    }
  }
}
