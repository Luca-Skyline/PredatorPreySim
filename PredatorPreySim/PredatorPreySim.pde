ArrayList<Predator> predators;
ArrayList<Prey> prey;

void setup(){
  size(1000, 1000);
  predators = new ArrayList<Predator>();
  prey = new ArrayList<Prey>();
  
  for(int i = 0; i < 20; i++){
    predators.add(new Predator(random(100.0, width-100.0), random(100.0, height-100.0)));
    
  }
  
  for(int i = 0; i < 80; i++){
    prey.add(new Prey(random(100.0, width-100.0), random(100.0, height-100.0)));
  }
  
  System.out.println("starting");
  
}

void draw(){
  background(0, 0, 0);
  for(int i = 0; i < predators.size(); i++){
    predators.get(i).update();
    for(int j = 0; j < predators.get(i).reproduce(); j++){
      predators.add(new Predator(predators.get(i).getX() + 5.0, predators.get(i).getY() + 5.0));
    }
    if(predators.get(i).dieNaturally()){
      predators.remove(i);
      i--;
    }
    else{
      predators.get(i).display(); 
      for(int j = 0; j < prey.size(); j++){
        if(predators.get(i).collision(prey.get(j))){
          System.out.println("collision");
          prey.remove(j);
          predators.get(i).addBaby();
        }
      }
    }
  }
  
  for(int i = 0; i < prey.size(); i++){
    prey.get(i).update();
    prey.get(i).display(); 
    if(prey.get(i).reproduce()){
      prey.add(new Prey(prey.get(i).getX() + 5.0, prey.get(i).getY() + 5.0));
    }
  }

}
