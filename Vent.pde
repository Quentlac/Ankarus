class Wind{
  
  private float Xa, Xb, Ya, Yb;
  
  private float intensity = 0;
  
  public PVector force;
  
  private Particule particules[] = new Particule[50];
  
  Balle balle;
  
  Wind(float xa, float ya, float xb, float yb, float intens, Balle b){
    this.Xa = xa;
    this.Xb = xb;
    this.Ya = ya;
    this.Yb = yb;
    
    intensity = intens;
    
    if(Xa - Xb == 0) Xa += 0.01;
    
    force = new PVector(Xb-Xa, Yb-Ya);
    force.setMag(intens);
    
    float a = (Yb-Ya)/(Xb-Xa);
    float p = Ya - a * Xa;
    
    for(int i = 0; i < 50;i++){
      
      float x, y;
      
      if(abs(a) <= 1){   
        x = i * (sqrt(pow(Xa-Xb, 2) + pow(Ya-Yb, 2)) / 50);  
        if(Xa > Xb)x *= -1;
     
        y = x * (Yb-Ya)/(Xb-Xa) + Ya;    
        
        x += Xa;
      }
      else{
        
        
        if(Ya > Yb)
          y = Ya - i * (sqrt(pow(Xa-Xb, 2) + pow(Ya-Yb, 2)) / 50);
        else
          y = i * (sqrt(pow(Xa-Xb, 2) + pow(Ya-Yb, 2)) / 50) + Ya;
        
        
        x  = (y - p)/a;
        
        
        
        
        
      }
 
      particules[i] = new Particule(random(x-30, x+30), random(y-30, y+30), force, force.mag(), color(random(240,255)));
      
      
    }
    
    balle = b;
 
  }
  
  Wind(){}
  
  
  public void affiche(Camera cam){
    for(int i = 0; i < 50;i++){
      particules[i].affiche(cam);       
      
    }
  }
  
  public void animation(){
    for(int i = 0; i < 50; i++){
      particules[i].move();  
      
      float distDroite = sqrt(pow(Xb - Xa, 2) + pow(Yb - Ya, 2));
      
      float posDroite = PVector.dot(new PVector(particules[i].getPosX() - Xa, particules[i].getPosY() - Ya), new PVector(Xb - Xa, Yb - Ya)) / distDroite;
      
      float dist = abs(distDroite/2 - posDroite);
    
      
      particules[i].setColor(color(255,255,255,map(dist, 0, distDroite/2, 255, 5)));
      
      
      
      if(posDroite > distDroite){
        particules[i].setPosition(random(Xa-30, Xa+30), random(Ya-30, Ya+30));  
        
      }
      
      
      
      
    }
    
  }
  
  public void collision(){
    println(Xa - Xb);
    
    //if(Xa - Xb == 0)Xa += 0.2;
    
    
    
    if(balle.posX > Xa - 12  && balle.posX < Xb + 12 || balle.posX < Xa - 12  && balle.posX > Xb + 12){
      float distDroite = sqrt(pow(Xb - Xa, 2) + pow(Yb - Ya, 2));
        
      float posDroite = PVector.dot(new PVector(balle.getPosX() - Xa, balle.getPosY() - Ya), new PVector(Xb - Xa, Yb - Ya)) / distDroite;    
      
      float distBalle = sqrt(pow(Xa - balle.getPosX(), 2) + pow(Ya - balle.getPosY(), 2));
      
      float distVent = sqrt(pow(distBalle, 2) - pow(posDroite, 2));
      
      if(distVent < 25){
        balle.addForce(force);
        //println("VENNNNT");
      }
      //println(distVent);
    }
    
    
  }
  
  
  public Wind clone(){
    Wind w = new Wind(Xa, Ya, Xb, Yb, intensity, balle);
    w.force = new PVector(force.x, force.y);
    
    //on transfert aussi les particules
    w.particules = particules;
    
    return w;
    
  }

  
  
}

class Particule{
  
  private float posX;
  private float posY;
  
  private PVector deplacement;
  
  private float vitesse;
  
  private color c;
  
  Particule(float x, float y, PVector dep, float vit, color colo){
    posX = x;
    posY = y;
    deplacement = dep;
    vitesse = vit;
    c = colo;
    
    deplacement.setMag(vitesse);
   
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
    posX += deplacement.x;
    posY += deplacement.y;
    
  }
  
  public void setColor(color col){
    c = col;  
  }
  
  public void affiche(Camera cam){
    stroke(c);
    strokeWeight(2.5);
    
    
    
    line(posX + cam.getPosX(), posY + cam.getPosY(), posX + deplacement.x*10 + cam.getPosX(), posY + deplacement.y*10 + cam.getPosY());
    
    
  }
  
 
}
