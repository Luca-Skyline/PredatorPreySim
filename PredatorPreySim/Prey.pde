public class Prey{
  private float x, y, r;
  private long age;
  private float x_speed;
  private float y_speed;
  private long lastFrame;
  private int birthRate; //ms
  private long deltaT;
  
  public Prey(float x, float y){
    lastFrame = System.currentTimeMillis();
    this.x = x;
    this.y = y;
    x_speed = 0.3 * (1+(-2*int(random(2))));
    y_speed = 0.0;
    age = 0;
    r = 8.0;
    birthRate = int(random(1000, 2000));
  }
  
  public void display(){
    noStroke();
    fill(0, 255, 0);
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
  
  public boolean reproduce(){
    if (age/birthRate != (age-deltaT)/birthRate){
      return true;
    }
    return false;
  }
  
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
}
