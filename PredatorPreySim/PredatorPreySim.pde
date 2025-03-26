ArrayList<Predator> predators;
ArrayList<Prey> prey;
int spawnLiklihood = 100;
Table data;
long deltaT;
long lastFrame;
long timeElapsed;


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
  
  
  data = new Table();
  data.addColumn("seconds");
  data.addColumn("predators");
  data.addColumn("prey");
  
  lastFrame = System.currentTimeMillis();
  timeElapsed = 0;
  
  
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
  
  //if(random(spawnLiklihood) > spawnLiklihood - 1){
  //  prey.add(new Prey(random(100.0, width-100.0), random(100.0, height-100.0)));
  //}
  //if(random(spawnLiklihood) > spawnLiklihood - 1){
  //  predators.add(new Predator(random(100.0, width-100.0), random(100.0, height-100.0)));
  //}
  deltaT = System.currentTimeMillis() - lastFrame;
  
  System.out.println(deltaT + timeElapsed);
  
  if((deltaT + timeElapsed)/1000 != (timeElapsed)/1000){ //a second has passed
    TableRow newRow = data.addRow();
    newRow.setInt("seconds", int((deltaT + timeElapsed)/1000));
    newRow.setInt("predators", predators.size());
    newRow.setInt("prey", prey.size());
    
    if((deltaT + timeElapsed) >= 60000){
      saveTable(data, "data/new.csv");
      exit();
    }
  }
  
  timeElapsed += deltaT;
  lastFrame = System.currentTimeMillis();


}
