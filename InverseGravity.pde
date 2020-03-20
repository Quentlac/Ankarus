class InverseGravity{
  private float posX, posY;
  
  private Balle balle;
  
  private boolean appui = false;
  
  InverseGravity(float posX, float posY, Balle balle){
    this.posX = posX;
    this.posY = posY;
    
    this.balle = balle;
    
    
  }
  
  InverseGravity(){
    this.posX = -50;
    this.posY = -50;
    
  }
  
  public float getPosX(){
    return posX;  
  }
  
  public float getPosY(){
    return posY;  
  }
  
  public void affiche(Camera cam){
    imageMode(CENTER);  
    
    if(niveau.gravity < 0)
      image(bouton_inverse_gravity_on, this.posX + cam.getPosX(), this.posY + cam.getPosY(), 50, 50);
    else
      image(bouton_inverse_gravity_off, this.posX + cam.getPosX(), this.posY + cam.getPosY(), 50, 50);
  }
  
  
  public void collision(){
    
    float dist = sqrt(pow(this.posX - balle.getPosX(), 2) + pow(this.posY - balle.getPosY(), 2));
    if(dist < 60 && !appui){
      niveau.gravity = -niveau.gravity;  
      this.appui = true;
     
    }
    else if(dist > 60){
      appui = false;  
    }
   
    
  }
  
  public void setPosition(float posX, float posY){
    this.posX = posX;
    this.posY = posY;
    
  }
  
  public InverseGravity clone(){
    return new InverseGravity(this.posX, this.posY, this.balle);  
    
  }
  
  
  
  
  
}
