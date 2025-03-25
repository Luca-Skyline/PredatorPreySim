public class Predator{
  
  private float x, y, r;
  private long age;
  private float x_speed;
  private float y_speed;
  private long lastFrame;
  private float life;
  private int babies;
  private boolean ate;
  private int birthRate;
  private long deltaT;
  private int maxBirths;
  private int totalBabies;
  
  public Predator(float x, float y){
    lastFrame = System.currentTimeMillis();
    this.x = x;
    this.y = y;
    x_speed = 0.3 * (1+(-2*int(random(2))));
    y_speed = 0.0;
    age = 0;
    r = 8.0;
    life = random(2500, 3500); //ms
    birthRate = int(random(200, 500));
    maxBirths = int(random(2, 4));
  }
  
  public void display(){
    noStroke();
    fill(255, 0, 0);
    circle(x, y, r*2);
  
  }
  
  public void update(){
     deltaT = System.currentTimeMillis() - lastFrame;
     //System.out.println(age);
     lastFrame = System.currentTimeMillis();
     age += deltaT;
     
     if(age/1000 != (age-deltaT)/1000){ //a second has passed
       float temp = x_speed;
       x_speed = y_speed * (1+(-2*int(random(2))));
       y_speed = temp * (1+(-2*int(random(2))));
       //System.out.println(x_speed + " " + y_speed);
     }
     
     if(x - r < 0 || x + r > width){
       x_speed = -x_speed;
       if(x - r < 0){
         x = r;
       }
       else{
         x = width - r;
       }
     }
     
     if(y - r < 0 || y + r > height){
       y_speed = -y_speed;
       if(y - r < 0){
         y = r;
       }
       else{
         y = height - r;
       }
     }
     
     x += x_speed * deltaT;
     y += y_speed * deltaT;
     
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  public boolean dieNaturally(){
    if(age > life){
      return true;
    }
    return false;
  }
  
  public void addBaby(){
    babies++;
    //totalBabies++;
    //life += 1000;
  }
  
  public int reproduce(){
    if (age/birthRate != (age-deltaT)/birthRate && totalBabies < maxBirths){
      int temp = babies;
      if(babies + totalBabies > maxBirths){
        temp = maxBirths - totalBabies;
      }
      totalBabies += temp;
      return temp;
      
    }
    return 0;
  }
  
  public boolean collision(Prey prey){
    if(sqrt(pow(prey.getX()-x,2)+ pow(prey.getY()-y,2)) < r*2){
      return true;
    }
    return false;
  }
}
