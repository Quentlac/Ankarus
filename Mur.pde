class Mur{
  public float Xa, Ya, Xb, Yb;
  
  private float absorption = 0.45;//0.45
  
  public Balle balle;
  
  private color couleur = color(255, 255, 255);
  
  Mur(float Xa, float Ya, float Xb, float Yb, Balle b){
    this.Xa = Xa;
    this.Ya = Ya;
    this.Xb = Xb;
    this.Yb = Yb;
    this.balle = b;
  }
  
  Mur(){}
  
  
  
  
  public void affiche(Camera cam){    
    stroke(255);
    strokeWeight(8);
    
    line(Xa + cam.getPosX(), Ya + cam.getPosY(), Xb + cam.getPosX(), Yb + cam.getPosY());
    
  }
  
  public void collision(){
    boolean collisionBalle = false;
    
    //on calcul l'éventuel point d'intersection entre 2 segments
    
    //on calcul les coefs directeurs des 2 segments
    float a, m;
        
    if(abs(Xa - Xb) < 0.5){
      Xa = Xb + 0.5;  
    }
        
    if(abs(Ya - Yb) < 0.5){
      Ya = Yb + 0.5;  
    }
    
    a = (Yb-Ya)/(Xb-Xa);
    
    //puis de la trajectoire
    
    PVector forceBalle = new PVector(balle.force.x, balle.force.y);
    
    
    if(forceBalle.mag() < balle.taille/2)
      forceBalle.setMag(balle.taille/1.3);
    
    if(forceBalle.x == 0)
      forceBalle.x = 0.01;  
      
    if(forceBalle.y == 0)
      forceBalle.y = 0.01;  
    
    
    m = forceBalle.y/forceBalle.x;
    
    //on calcul maintenant les ordonnees à l'origine
    float b, p;
    
    b = Ya - a * Xa;
    p = balle.getPosY() - m * balle.getPosX();
    
    //on fait l'équation de distance à une droite (Merci Nicolas)
    
    float R = balle.taille/2 + 4;
    
    //on cherche l'intervalle dans laquelle l'équation est résolu -> voir fichier géogebra
    
    float xInterA = (R * sqrt(pow(a, 2) + 1) + p - b) / (a - m);
    float xInterB = (R * sqrt(pow(a, 2) + 1) - p + b) / (m - a);
    
    //on calcul la distance entre ces deux valeurs
    float distIntervalle = abs(xInterA - xInterB);
    
    float centreIntervalle = (xInterA + xInterB) / 2;
    
    float distMur = abs(Xa - Xb);
    
    if(distMur == 0)distMur += 0.01;
    
    float centreMur = (Xa + Xb) / 2; 
    
    float distBalle = abs(balle.getPosX() - (balle.getPosX() + balle.force.x));
    float centreBalle = (balle.getPosX() + (balle.getPosX() + balle.force.x)) / 2;
        
    //On vérifie maintenant si la somme des distances entre les centres est inférieur à la moyenne.
    
    if(abs(centreBalle - centreIntervalle) <= (distIntervalle + distBalle) / 2 && abs(centreMur - centreIntervalle) <= (distIntervalle + distMur) / 2){
      
      //pour des soucis d'arrondis, suivant l'orientation du mur, nous devons vérifier l'intervalle soit avec les ordonnées soit avec les origines
      if(abs(a) >= 1 && abs(((balle.getPosY() + (balle.getPosY() + balle.force.y)) / 2) - ((Ya + Yb)/2)) <= (abs(Ya - Yb) + abs(balle.getPosY() - (balle.getPosY() + balle.force.y)))/2){
        collisionBalle = true;  
      }
      if(abs(a) < 1 && abs(centreMur - centreBalle) <= (distBalle + distMur) / 2){
        collisionBalle = true;  
      }
    }
    

    println(a-m);
    
    if(collisionBalle == true){
      nbCol++;
 
      //calcul de la force appliqué par le mur (perpendiculaire)
      
      float coefDirecteur = -1 / ((Ya - Yb)/(Xa - Xb));
      PVector forceMur = new PVector(1, coefDirecteur);
      
      
      if(PVector.angleBetween(forceMur, balle.force) <= PI/2){
        forceMur.setMag(-(2-absorption)*sqrt(pow(balle.force.mag(), 2) - pow(PVector.dot(new PVector(Xa-Xb, Ya-Yb), balle.force)/sqrt(pow(Xa-Xb, 2)+pow(Ya-Yb, 2)), 2))); 
      }
        
      else{
        forceMur.setMag((2-absorption)*sqrt(pow(balle.force.mag(), 2) - pow(PVector.dot(new PVector(Xa-Xb, Ya-Yb), balle.force)/sqrt(pow(Xa-Xb, 2)+pow(Ya-Yb, 2)), 2)));  
      }
      
      //delay(3000);
      
      //line(500,500, 500-forceMur.x, 500-forceMur.y);
      //delay(1000);
      
      if(forceMur.mag() > 5){
        vibration();   
      }
      
      balle.addForce(forceMur); 
      
      
      //on vérifie si la balle est dans un mur à cause d'un bug
      a = (Ya - Yb)/(Xa - Xb);
      b = -a * Xa + Ya;
        
      float dist = abs(a * balle.getPosX() - balle.getPosY() + b)/sqrt(pow(a, 2) + 1);
      
      if(dist <= R){
        
        coefDirecteur = (Ya - Yb)/(Xa - Xb);
        b = Ya - coefDirecteur * Xa;
        
        if(Ya - Yb == 0)Ya += 0.1;
        
        float coefDirecteurP = -1 / ((Ya - Yb)/(Xa - Xb));
        float bP = balle.getPosY() - coefDirecteurP * balle.getPosX();
        
        //on calcul l'intersection entre les 2
        float Xi = (bP - b)/(coefDirecteur - coefDirecteurP);
        
        
        
        float Yi = (coefDirecteurP * Xi) + bP;
                
        if(balle.getPosX() < Xi && balle.getPosY() > Yi){
          println("AAA");
          balle.setPosition(Xi - sqrt(pow(R, 2)/(pow(coefDirecteurP, 2) + 1)), coefDirecteurP * (Xi - sqrt(pow(R, 2)/(pow(coefDirecteurP, 2) + 1))) + bP);
          
        }
        else if(balle.getPosX() >= Xi && balle.getPosY() < Yi){
          println("BBB");
          balle.setPosition(Xi + sqrt(pow(R, 2)/(pow(coefDirecteurP, 2) + 1)), coefDirecteurP * (Xi + sqrt(pow(R, 2)/(pow(coefDirecteurP, 2) + 1))) + bP);
          
        }
        else if(balle.getPosX() > Xi && balle.getPosY() >= Yi){
          println("CCC");
          balle.setPosition(Xi + sqrt(pow(R, 2)/(pow(coefDirecteurP, 2) + 1)), coefDirecteurP * (Xi + sqrt(pow(R, 2)/(pow(coefDirecteurP, 2) + 1))) + bP);
          
        }
        else if(balle.getPosX() < Xi && balle.getPosY() < Yi){
          println("DDD");
          balle.setPosition(Xi - sqrt(pow(R, 2)/(pow(coefDirecteurP, 2) + 1)), coefDirecteurP * (Xi - sqrt(pow(R, 2)/(pow(coefDirecteurP, 2) + 1))) + bP);
          
        }
        
        //balle.setForce(new PVector(0, 0));
        
        
        
        
      }
    }
    else{
    
      //on test mtn les extrêmités
      //on commence avec l'un des 2 points (A)
      
      R -= 1;
      
      
      
      
      float delta = pow(-2 * Xa - 2 * Ya * m + 2 * m * p, 2) - 4*(1+pow(m, 2))*(-pow(R, 2) + pow(Xa, 2) + pow(Ya, 2) - 2 * Ya * p + pow(p,2));
      
      if(delta > 0 && abs(balle.force.x) > 0){
        float X0 = (-(-2*Xa - 2*Ya*m + 2*m*p)-  sqrt(delta)) / (2*(1+pow(m, 2)));
        float X1 = (-(-2*Xa - 2*Ya*m + 2*m*p) + sqrt(delta)) / (2*(1+pow(m, 2)));
        
        
        if(abs(centreBalle - (X0+X1)/2) < (distBalle + abs(X0-X1))/2){
          nbCol++;
          
          balle.addForce(new PVector(balle.getPosX() - Xa, balle.getPosY() - Ya).setMag(balle.force.mag()*1.1));
          //delay(1000);
          
        }
      }
      else{
      
        delta = pow(-2 * Xb - 2 * Yb * m + 2 * m * p, 2) - 4*(1+pow(m, 2))*(-pow(R, 2) + pow(Xb, 2) + pow(Yb, 2) - 2 * Yb * p + pow(p,2));
        
        if(delta > 0 && abs(balle.force.x) > 0){
          float X0 = (-(-2*Xb - 2*Yb*m + 2*m*p)-  sqrt(delta)) / (2*(1+pow(m, 2)));
          float X1 = (-(-2*Xb - 2*Yb*m + 2*m*p) + sqrt(delta)) / (2*(1+pow(m, 2)));
          
          
          if(abs(centreBalle - (X0+X1)/2) < (distBalle + abs(X0-X1))/2){
            nbCol++;
            
            balle.addForce(new PVector(balle.getPosX() - Xb, balle.getPosY() - Yb).setMag(balle.force.mag()*1.1));   //.setMag(balle.force.mag()*1)
            //delay(1000);
          }
        }
        else{
        
          if(sqrt(pow(Xa - balle.getPosX(), 2) + pow(Ya - balle.getPosY(), 2)) < R+1){
            println("aiiiii");
            //delay(1000);
             //la balle est coincé dans l'extremité
             
             PVector correction = new PVector(balle.getPosX() - Xa, balle.getPosY() - Ya).setMag(R+2);
             balle.setPosition(Xa + correction.x, Ya + correction.y);
          }
          
          if(sqrt(pow(Xb - balle.getPosX(), 2) + pow(Yb - balle.getPosY(), 2)) < R+1){
            println("aiiiii");
            //delay(1000);
             //la balle est coincé dans l'extremité
             
             PVector correction = new PVector(balle.getPosX() - Xb, balle.getPosY() - Yb).setMag(R+2);
             balle.setPosition(Xb + correction.x, Yb + correction.y);
          }
        }
      }

    }
    
    
  }
  
  
  public Mur clone(){
    Mur m = new Mur(Xa, Ya, Xb, Yb, balle);
    return m; 
    
  }
  
 
  
  
  
}
