class Explosion{
  
  public boolean active = false;
  
  private float posX, posY;  
  private float rayonChoque = 0;  
  private Balle balle;
  
  private float vitesse = 15;
  private float force = 1;
  
  private boolean action = false;
  
  Explosion(float x, float y, Balle b){
    if(niveau.nbExploRestant > 0){
      posX = x;
      posY = y;
      
      balle = b;
      
      active = true;
      
      niveau.nbExploRestant--;
    }
  }
  
  Explosion(){}
  
  public void affiche(Camera cam){
    if(active){
      noFill();
      stroke(255, 255, 255, map(rayonChoque, 0, 200, 255, 0));
      strokeWeight(5);  
      
      ellipse(posX + cam.getPosX(), posY + cam.getPosY(), rayonChoque, rayonChoque);
      
    }    
  }
  
  
  public void move(){
    if(active){
      rayonChoque += vitesse;
      

      if(rayonChoque > 300)
        active = false;
    }
  }
  
  
  public void collision(){
    if(active && !action){
      float dist = sqrt(pow(posX-balle.getPosX(), 2) + pow(posY - balle.getPosY(), 2));
      
      if(dist < rayonChoque){
        PVector forceDeviation = new PVector(balle.getPosX() - posX, balle.getPosY() - posY);
        forceDeviation.setMag(map(dist, 0, 300, 15.0, 0.1));
        balle.setForce(forceDeviation); 
        action = true;
      }    
    }    
  }
  

  
  
  
  
  
  
}
