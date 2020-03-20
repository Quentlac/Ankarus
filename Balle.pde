class Balle{
  
  private float posX = 0;
  private float posY = 0;
  
  private float taille = 30;
  
  private float masse = 10;
  
  
  private PVector force = new PVector(0, 0);
  private PVector forceTmp = new PVector(0, 0);
  
  Balle(float x, float y, float t){
    posX = x;
    posY = y;    
    taille = t;
  }
  
  public float getPosX(){
    return posX;  
  }
  
  public float getPosY(){
    return posY;  
  }
  
  public void setPosition(float x, float y){
    posX = x;
    posY = y;
  }
  
  public void move(){
    
    posX += force.x;
    
    if(abs(force.y) > 0.8)
      posY += force.y;

    
    //force de gravité
    addForce(new PVector(0, masse * niveau.gravity));
    
  }
  
  public void addForce(PVector newForce){
      force.add(newForce);
    
  }
  
  public void addForceTmp(PVector newForce){
      forceTmp.add(newForce);
    
  }
  
  public void syncForce(){
    force = new PVector(forceTmp.x, forceTmp.y); 
    
  }
  
  public void setForce(PVector newForce){
      force = newForce;
    
  }
  
  public PVector getForce(){   
    return new PVector(force.x, force.y);
  }
  
  public void affiche(Camera cam){
    fill(255);
    stroke(255);
    strokeWeight(1);
    
    ellipse(posX + cam.getPosX(), posY + cam.getPosY(), taille, taille);
    
    //flou de mouvement
    //noStroke();
    //for(int i = 0; i < 6;i++){
      
    //  fill(255,255,255,100-i*30);
    //  ellipse(posX-(0.5*i*force.x) + cam.getPosX(), posY-(0.5*i*force.y) + cam.getPosY(), taille, taille);
    //}
    
    //line(posX, posY, posX + force.x, posY + force.y);
    
  }
  
  public Balle clone(){
    Balle b = new Balle(posX, posY, taille);
        
    return b;
    
  }
  
  
  
  
  
  
  
}
