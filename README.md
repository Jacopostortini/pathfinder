# pathfinder

Path finder is a processing sketch that implements a genetic algorithm. The purpose is to find the best way for the particles to get to the target (green square).

During run time the user can create obstacles that the particles will have to overcome by pressing and dragging the mouse.
In the corner there is the generation count and the average fitness of the current population. 

The fitness is calculated by the formula

  1/(distance<sup>n</sup> · timealive<sup>m</sup>) 

where the distance is the distance from the target and the timealive is the time that the particle
survives. You can modify the weight of the two factors in the formula by changing the exponents n and m. Of course a particle that ends up 
very close to the target or that does not wanders in the space for a lot of time will more probably pass its genes to the next generation.

The DNA is a set of vectors that are applied to the velocity of the particle during its lifetime.
