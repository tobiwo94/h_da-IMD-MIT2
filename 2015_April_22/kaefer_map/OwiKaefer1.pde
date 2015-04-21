class OwiKaefer1 extends Kaefer {
  
  float noiseP;
  
  OwiKaefer1() {
 
     super();
     speed = random(0.5, 2.0);
     direction.rotate(random(TWO_PI));
     direction.mult(speed);
     noiseP = 0;
     
  }
  
  void draw() {
    
    PVector mouth = new PVector(direction.x, direction.y);
    mouth.normalize();
    mouth.mult(10);
    mouth.add(position);
    
    boolean eat = false;
    if(map.get((int)mouth.x, (int)mouth.y)==color(0)) direction.rotate(PI);
    if(map.get((int)mouth.x, (int)mouth.y)==color(0,255,18)) eat = true;
    if(eat) {
      
      if(frameCount%10==0) {
        
        color white = color(255);
        int biteX = (int)mouth.x;
        int biteY = (int)mouth.y;
        for(int i=0; i<60; i++) {
          map.set(biteX+(int)random(-4, 4), biteY+(int)random(-4, 4), white);
        }
        noiseP += 0.2;
        direction.rotate((noise(noiseP)-0.5)*0.5);
      }
    }
    
    // update position
    noiseP += 0.02;
    direction.rotate((noise(noiseP)-0.5)*0.05);
    
    if(!eat) position.add(direction);
    checkBorder();
    
    // draw kaefer
    fill(255);
    ellipse(position.x, position.y, 20, 20);
    
    // mittellinie
    PVector m = new PVector(direction.x, direction.y);
    m.normalize();
    line(position.x-m.x*10,
    position.y-m.y*10, 
    position.x+m.x*10, 
    position.y+m.y*10
    );
    
    // fühler
    PVector f1 = new PVector(direction.x, direction.y);
    f1.normalize();
    f1.rotate(-0.5);
    line(position.x+f1.x*10,
    position.y+f1.y*10, 
    position.x+f1.x*20, 
    position.y+f1.y*20
    );
    f1.rotate(1);
    line(position.x+f1.x*10,
    position.y+f1.y*10, 
    position.x+f1.x*20, 
    position.y+f1.y*20
    );
    
  }
  
  void checkBorder() {
    
    if(position.x<0 || position.x>width) direction.x *= -1;
    if(position.y<0 || position.y>height) direction.y *= -1;
  }
}
