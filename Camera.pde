class Camera{  
  private float echelle = 1;
  
  private float posX = 0;
  private float posY = 0;
  
  
  Camera(float x, float y, float ech){
    posX = x;
    posY = y;
    
    echelle = ech;
    
    
  }
  
  public void setPosition(float x, float y){
    posX = x;
    posY = y;
  }
  
  public float getPosX(){
    return posX;
    
  }
  
  public float getPosY(){
    return posY;  
  }
  
  public float getEchelle(){
    return echelle;  
  }
  
  
  
  
  public void followBalle(Balle b){
    //if(b.getPosX() > -posX+700){
    //  posX -= map(b.getPosX() - (-posX+700), 0, 200, 0, 5);  
    //}
    
    //else if(b.getPosX() < -posX+580){
    //  posX += map((-posX+580) - b.getPosX(), 0, 200, 0, 5);  
    //}
    
    //if(b.getPosY() > -posY+420){
    //  posY -= map(b.getPosY() - (-posY+420), 0, 200, 0, 5);  
    //}
    
    //else if(b.getPosY() < -posY+300){
    //  posY += map((-posY+300) - b.getPosY(), 0, 200, 0, 5);
    //}
    
    
    float distX = (float(width)/(float(width)/1280*echelle))/2 - posX;
    float distY = (float(height)/niveau.echelleCamera)/2 - posY;
        
    if(b.getPosX() > distX){
      posX -= (b.getPosX() - (distX)) / 5;  
    }
    
    if(b.getPosX() < distX){
      posX += ((distX) - b.getPosX()) / 5;  
    }
    
    if(b.getPosY() > distY){
      posY -= (b.getPosY() - (distY)) / 5;  
    }
    
    if(b.getPosY() < distY){
      posY += ((distY) - b.getPosY()) / 5;
    }
    



    
    
    
  }
  
  
  public Camera clone(){
    return new Camera(posX, posY, echelle);  
    
    
  } 
  
  
  
}
