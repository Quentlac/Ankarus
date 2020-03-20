class Agrandisseur{
  
  private float posX, posY;
  private Balle balle;
  
  private float tailleBalle = 50;
  
  
  Agrandisseur(float posX, float posY, Balle balle, float tailleBalle){
    
    this.posX = posX;
    this.posY = posY;
    
    this.balle = balle;
    this.tailleBalle = tailleBalle;
  
  }
  
  Agrandisseur(){}
  
  public float getPosX(){
    return posX;  
  }
  
  public float getPosY(){
    return posY;  
  }
  
  
  public void affiche(Camera cam){
    imageMode(CENTER);  
    
    if(tailleBalle > 20){
      image(agrandisseur_img, this.posX + cam.getPosX(), this.posY + cam.getPosY(), 80, 80);    
    }
    else if(tailleBalle < 20){
      image(retrecisseur_img, this.posX + cam.getPosX(), this.posY + cam.getPosY(), 80, 80);  
    }
    else{
      image(egaliseur_img, this.posX + cam.getPosX(), this.posY + cam.getPosY(), 80, 80);  
    }
    
  }
  
  public void collision(){
    //on test les collision seulement si la taille est pas bonne
    
    if(abs(balle.taille - this.tailleBalle) > 5){
      float dist = sqrt(pow(this.posX - balle.getPosX(), 2) + pow(this.posY - balle.getPosY(), 2));
      
      if(dist < 60){
        //on créé une attraction (magnétique)
        balle.setForce(new PVector(this.posX - balle.getPosX(), this.posY - balle.getPosY()).setMag(balle.force.mag()/1.03)); 
        
        if(dist < 20){
          //on va maitenant changer la taille de la balle
          
          if(balle.taille < this.tailleBalle){
            balle.taille += 0.2;  
          }
          
          else if(balle.taille > this.tailleBalle){
            balle.taille -= 0.1;  
          }
          
        }
      }
    }
    
  }
  
  public void setPosition(float posX, float posY){
    this.posX = posX;
    this.posY = posY;
    
  }
  
  public Agrandisseur clone(){
    return new Agrandisseur(this.posX, this.posY, this.balle, this.tailleBalle);  
    
  }
  
  
}
