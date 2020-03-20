class Niveau{
  private Mur liste_mur[] = new Mur[100];
  private Mur liste_mur_backup[] = new Mur[100]; // mur qui sert à éviter la désynchronisation entre le thread principal et l'autre
  
  private Wind liste_vent[] = new Wind[10];
  private Wind liste_vent_backup[] = new Wind[10];
  
  private InverseGravity liste_inv_gravity[] = new InverseGravity[10];
  private InverseGravity liste_inv_gravity_backup[] = new InverseGravity[10];
  
  private Agrandisseur liste_agrand[] = new Agrandisseur[10];
  private Agrandisseur liste_agrand_backup[] = new Agrandisseur[10];
  
  private Balle balle;
  private Balle balle_backup = new Balle(0, 0, 100);
  
  private int nbMur = 0;
  private int nbVent = 0;
  private int nbInverseGravity = 0;
  private int nbAgrand = 0;
  
  private Explosion explo = new Explosion();
  
  private float gravity = 0.04;//0.04
  
  public float xFin, yFin;
  public float xDep, yDep;
  
  public Camera cameraGame = new Camera(0, 0, 1.5);
  private Camera cameraBackup;
  
  private float echelleCamera;
  
  public boolean win = false;
  
  private TrouNoir trou_noir;
  
  public int nbExploUtil = 0;
  public int nbExploMax = 0;
  public int nbExploRestant = 0;
  
  
  
  Niveau(JSONObject level){
    explo.active = false;
  
    gravity = 0.04;
  
    echelleCamera = float(height)/720*cameraGame.getEchelle();
    
    chargeNiveau(level);  
    
    trou_noir = new TrouNoir(xFin, yFin);
    
    win = false;
    respawnBalle();
    

  }
  
  
  Niveau(){
    
    this.xDep = -50;
    this.yDep = -50;
    
    this.xFin = -100;
    this.yFin = -50;
    
    explo.active = false;
    gravity = 0.04;
  
 
    echelleCamera = float(height)/720;
    balle = new Balle(xDep, yDep, 20);
    
    trou_noir = new TrouNoir(xFin, yFin);
  }
  
  
  
  private void chargeNiveau(JSONObject level){
    //JSONObject level = decryptJSONFile("level.json");
    

    
    xDep = level.getFloat("xDep");
    yDep = level.getFloat("yDep");
    
    balle = new Balle(xDep, yDep, 20);
    balle.addForce(new PVector(0, -4));
    
    nbExploMax = level.getInt("nbExploMax");
    nbExploRestant = nbExploMax;
    
    ui.compteurExplo.setTotal(nbExploRestant);
    
    xFin = level.getFloat("xFin");
    yFin = level.getFloat("yFin");
        
    JSONArray listeMurJSON = level.getJSONArray("listeMur");
    nbMur = listeMurJSON.size();
    
    for(int i = 0; i < listeMurJSON.size(); i++){
      JSONObject murCaract = listeMurJSON.getJSONObject(i);
      
      liste_mur[i] = new Mur(murCaract.getFloat("Xa"), murCaract.getFloat("Ya"), murCaract.getFloat("Xb"), murCaract.getFloat("Yb"), balle); 
    }
    
    JSONArray listeVentJSON = level.getJSONArray("listeVent");
    nbVent = listeVentJSON.size();
    
    for(int i = 0; i < listeVentJSON.size(); i++){
      JSONObject ventCaract = listeVentJSON.getJSONObject(i);
      
      liste_vent[i] = new Wind(ventCaract.getFloat("Xa"), ventCaract.getFloat("Ya"), ventCaract.getFloat("Xb"), ventCaract.getFloat("Yb"), ventCaract.getFloat("intens"), balle); 
    }
    
    JSONArray listeInverseGravityJSON = level.getJSONArray("listeInverseGravity");
    nbInverseGravity = listeInverseGravityJSON.size();
    
    for(int i = 0; i < listeInverseGravityJSON.size(); i++){
      JSONObject inverseCaract = listeInverseGravityJSON.getJSONObject(i);
      
      liste_inv_gravity[i] = new InverseGravity(inverseCaract.getFloat("posX"), inverseCaract.getFloat("posY"), balle); 
    }
    
    JSONArray listeAgrandisseurJSON = level.getJSONArray("listeAgrandisseur");
    nbAgrand = listeAgrandisseurJSON.size();
    
    for(int i = 0; i < listeAgrandisseurJSON.size(); i++){
      JSONObject agrandCaract = listeAgrandisseurJSON.getJSONObject(i);
      
      liste_agrand[i] = new Agrandisseur(agrandCaract.getFloat("posX"), agrandCaract.getFloat("posY"), balle, agrandCaract.getFloat("tailleBalle")); 
    }

    
   
  }
  
  
  public void affichage(){
    pushMatrix();

    imageMode(CORNER);  
    image(backgroundImg, cameraGame.getPosX()/3-50, cameraGame.getPosY()/3-50);
    
    //on récupère l'état actuel des élements à afficher
    balle_backup = balle.clone();
    for(int i = 0; i < nbMur; i++){
      liste_mur_backup[i] = liste_mur[i].clone();    
    }
    
    for(int i = 0; i < nbVent; i++){
      liste_vent_backup[i] = liste_vent[i].clone();    
    }
    
    for(int i = 0; i < nbInverseGravity; i++){
      liste_inv_gravity_backup[i] = liste_inv_gravity[i].clone();    
    }
    
    for(int i = 0; i < nbAgrand; i++){
      liste_agrand_backup[i] = liste_agrand[i].clone();    
    }
    
    cameraBackup = cameraGame.clone();
    
    scale(echelleCamera); 
    
    
    stroke(255);
    
  
    
  
    for(int i = 0; i < nbMur;i++){
      liste_mur_backup[i].affiche(cameraBackup);  
    }
    
    for(int i = 0; i < nbVent;i++){
      liste_vent_backup[i].affiche(cameraBackup);  
    }
    
    for(int i = 0; i < nbInverseGravity;i++){
      liste_inv_gravity_backup[i].affiche(cameraBackup);  
    }
    
    for(int i = 0; i < nbAgrand;i++){
      liste_agrand_backup[i].affiche(cameraBackup);  
    }
    
    trou_noir.affiche(cameraBackup);
    
    balle_backup.affiche(cameraBackup);

    explo.affiche(cameraBackup);
    
    //fill(255, 0, 0);
    //ellipse(xTest + cameraGame.getPosX(), yTest + cameraGame.getPosY(), 5, 5);
        
    //println(xTest + " " + yTest);
    
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("NIVEAU " + (niveauID + 1), 750, 450);
    

    popMatrix();
    
    if(viseur)
      afficheViseur(cameraBackup);
    

    
    
  }
  
  public void moteurPhysique(){
    if(!win && scene == 3 && !pause){
      cameraGame.followBalle(balle);
      
      if(!viseur)
        balle.move();
      
      //on s'occupe du cas où la personne relache le viseur pour tirer
      if(!mousePressed){
        if(viseur){
          float posX = mouseX;
          float posY = mouseY;
          
          PVector vecteurTire = new PVector(viseurPosX - posX, viseurPosY - posY).mult(0.3);
          
          if(vecteurTire.mag() > 16)vecteurTire.setMag(16);
          balle.setForce(vecteurTire);   
          nbExploRestant--;
        }
          
        viseur = false;  
      }  
      
      //explo.move();
      //explo.collision();
      
      for(int i = 0; i < nbVent;i++){
        liste_vent[i].collision();  
        liste_vent[i].animation();
      }
      
      
     

      do{
        nbCol = 0;
        for(int i = 0; i < nbMur;i++){
          liste_mur[i].collision();  
        }
      }while(nbCol > 1);
      
                    
        
      //println(balle.getPosX() + " ; " + balle.getPosY());
      
      
      
      
      
      for(int i = 0; i < nbInverseGravity;i++){
        liste_inv_gravity[i].collision();  
      }
      
      for(int i = 0; i < nbAgrand;i++){
        liste_agrand[i].collision();  
      }
      
      
      
    }
    
    
   
    
    niveauManager();
    
  }
  
  private void afficheViseur(Camera cam){
    float posX = mouseX;
    float posY = mouseY;
    
    PVector vecteurTire = new PVector(viseurPosX - posX, viseurPosY - posY).mult(3);
    
    
  
    noFill();
    stroke(255,255,255, 175);
    strokeWeight(5);
    ellipse(viseurPosX, viseurPosY, 80, 80);
    
    float dist = sqrt(pow(posX - viseurPosX, 2) + pow(posY - viseurPosY, 2));
    
    if(dist > 200){
      float a = (posY - viseurPosY)/(posX - viseurPosX);    
      float b = posY - a*posX;
      
      
      float xCurs = 200 * (posX - viseurPosX) / dist;
      
      posX = xCurs + viseurPosX;
      posY = a*(posX)+b;
      
      vecteurTire.setMag(600);
      
    }
    
    ellipse(posX, posY, 50, 50);
    
    line(viseurPosX, viseurPosY, posX, posY);
    
    pushMatrix();
    scale(echelleCamera); 
    fill(255);
    line(balle.getPosX() + cam.getPosX(), balle.getPosY() + cam.getPosY(), balle.getPosX() + vecteurTire.x*0.3 + cam.getPosX(), balle.getPosY() + vecteurTire.y*0.3 + cam.getPosY());  
  
    popMatrix();
    

  }
  
  
  public void niveauManager(){
    //on test si la balle est dans le trou noir
    
    if(sqrt(pow(balle.getPosX() - xFin, 2) + pow(balle.getPosY() - yFin, 2)) < 60){
      if(balle.taille > 0){
        balle.taille -= 1;  
      }
      
      if(sqrt(pow(balle.getPosX() - xFin, 2) + pow(balle.getPosY() - yFin, 2)) < 40){
        if(trou_noir.taille > 0){
          trou_noir.taille -= 3;  
        }
        
      }
      
      if(trou_noir.taille <= 0 && !win){
         win = true; 
         if(speedrun_mode){
           
           
         }
         
         else{
         
           if(niveauID >= reussite_niveau[packID]){
             reussite_niveau[packID]++;
             //on donne les récompenses
             XP += 10;
             
             if(XP > pow(niv_joueur, 1.5)*10){
               niv_joueur++;
               XP = 0;
             }
             
             coin += 30;
           }
           
           sauvegarde();
         }
      }
      
    }
    
    
     //on créé une attraction à proximité du trou noir
    if(sqrt(pow(balle.getPosX() - xFin, 2) + pow(balle.getPosY() - yFin, 2)) < 60){
      balle.setForce(new PVector(xFin - balle.getPosX(), yFin - balle.getPosY()).setMag(2));   
      
    }
    
  }
  
  public void creeExplosion(float posX, float posY){
    explo = new Explosion(posX, posY, balle);  
  
  }
  
  public void ajouteMur(Mur m){
    liste_mur[nbMur] = m.clone();
    
    liste_mur[nbMur].balle = balle;
    
    nbMur++;
    

  }
  
  public void ajouteVent(Wind v){
    liste_vent[nbVent] = v.clone();
    
    nbVent++;
    
  }
  
  public void ajouteInverseGravity(InverseGravity g){
    liste_inv_gravity[nbInverseGravity] = g.clone();
    
    nbInverseGravity++;
    
  }
  
  public void ajouteAgrandisseur(Agrandisseur a){
    liste_agrand[nbAgrand] = a.clone();  
    
    nbAgrand++;
  }
  
  public void respawnBalle(){
    balle.setPosition(xDep, yDep);  
    balle.force = new PVector(0, 0);
    balle.taille = 25;
    gravity = 0.04;
  }
  
  
}



class TrouNoir{
  private float posX, posY;
  
  public float taille;
  
  TrouNoir(float x, float y){
    posX = x;
    posY = y;
    
    taille = 100;
    
  }
  
  
  public void affiche(Camera cam){
    imageMode(CENTER);
    image(trou_noir,posX + cam.getPosX(), posY + cam.getPosY(), taille, taille);    
    
  }
  
  public void setPosition(float x, float y){
    posX = x;
    posY = y;
    
  }
  
  
  
}
