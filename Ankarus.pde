
//import java.security.*;
//import javax.crypto.*;

PImage trou_noir;
PImage backgroundImg;
PImage bouton_inverse_gravity_off;
PImage bouton_inverse_gravity_on;
PImage agrandisseur_img;
PImage retrecisseur_img;
PImage egaliseur_img;

PImage devistorm_logo;

PImage titre_logo;
PImage coin_img;
PImage trophe;
PImage badgeNiveau;
PImage horloge_icon;

PImage icon_son[] = new PImage[2];



SoundFile introSound;
SoundFile ankarus_theme;


PFont compteur_font;

int test = 0;

int numNiveau = 1;//numéro du niveau a jouer

Niveau niveau;

int nbCol = 0;

UI ui;

int scene = 1; //1 = menu principal

boolean speedrun_mode = true;
int speedrun_level = 0;

int packID = 0;
int niveauID = 0;

int coin = 0;
int XP = 0;
int niv_joueur = 1;


//chaques cases du tableau correspond à un pack, et sa valeur à l'avancé de ce pack
int reussite_niveau[] = new int[10];


//variable pour le dragMouse dans le menuPrincipal
float dragX = 0;
float dragY = 0;
float cursX = 0;
float ancienCursX = 0;
int select = 0;

JSONArray liste_pack_json;

boolean viseur = false;
float viseurPosX = 0;
float viseurPosY = 0;

String cleAES = "K3d5(p5UN&2!Y+fb";




boolean transition = false;
long animationTransition = 0;

boolean pause = false;

int randMsg = 0;

boolean musicplay = false;

boolean music_active = false;

//InterstitialAd mInterstitialAd;

void setup(){
  
  
  frameRate(60);
  
  //size(1280, 720, P2D);
  //smooth(4);

  fullScreen(P2D);
  orientation(LANDSCAPE);
  
  devistorm_logo = loadImage("Images/devistorm_logo.png");
  
  
  introSound = new SoundFile(this, "Sons/intro.mp3");
  thread("threadLoading");
  
  
  //démmarage des threads
  
  
  init();
   
  delay(100);
  
  

  randMsg = round(random(0,6));
  
  
 
  transition = true;
  animationTransition = millis();
}



void draw(){

  if(transition){
    afficheTransition();  
  }
  else{
    background(24, 137, 154);
    
    if(scene == 1){
      menuPrincipal();  
    }
    else if(scene == 2){
      afficheListeNiveau(packID);  
    }
    else if(scene == 3){
    
      ui.collisionsBoutons();
      
      
      //println(frameRate);
      
      
      niveau.affichage();
     
      if(niveau.win)
        afficheWinScreen();
      
      if(pause){
        affichePause();    
      }
      
      ui.affichage();
      
      
    }
  }
  
}


void threadLoading(){
  ankarus_theme = new SoundFile(this, "Sons/bande_son.mp3");  
  
  backgroundImg = loadImage("Images/background.png");
  backgroundImg.resize(int(width*1.5), int(height*1.5));
  
  trou_noir = loadImage("Images/trou_noir.png");
  bouton_inverse_gravity_off = loadImage("Images/bouton_inverse_gravity_off.png");
  bouton_inverse_gravity_on = loadImage("Images/bouton_inverse_gravity_on.png");
  agrandisseur_img = loadImage("Images/agrandisseur.png");
  retrecisseur_img = loadImage("Images/retrecisseur.png");
  egaliseur_img = loadImage("Images/egaliseur.png");
  titre_logo = loadImage("Images/titre_logo.png");
  coin_img = loadImage("Images/coin.png");
  trophe = loadImage("Images/trophe.png");
  badgeNiveau = loadImage("Images/badge.png");
  horloge_icon = loadImage("Images/horloge.png");
  
  icon_son[0] = loadImage("Images/son_on.png");
  icon_son[1] = loadImage("Images/son_off.png");
  
  JSONObject pack_json = decryptJSONFile("packNiveau.json");
  liste_pack_json = pack_json.getJSONArray("listePacks");
  
  ui = new UI();
  
  niveau = new Niveau();
  getSauvegarde();
  
}



void threadMouvement(){
  while(true){
   
    niveau.moteurPhysique();  
    
    delay(17);//60fps
  }
}



void menuPrincipal(){
  pushMatrix();
  scale(float(height)/720);
  
  imageMode(CORNER);  
  image(backgroundImg, 0, 0, width, height);
  
  
  image(titre_logo, 10, 10, 307, 71);
  
  fill(255, 255, 255, 60);
  noStroke();
  rect(0, 175, 1280, 250);
  
  fill(255, 255, 255, 200);
  stroke(0);
  strokeWeight(2);
  
  rect(1100, 20, 170, 50, 10, 10, 10, 10);
  image(coin_img, 1220, 25, 40, 40);
    
    
  textSize(30);
  textAlign(LEFT);
  fill(0);
  text(round(coin) ,1110, 55); 
  
  pushMatrix();
  translate(cursX, 0);
  
  JSONObject pack = liste_pack_json.getJSONObject(0);
    
  imageMode(CORNER);
  image(loadImage(pack.getString("miniature")), 52, 150, 480, 310);
  
  noStroke();
  fill(50, 50, 50);
  rect(372, 150, 160, 310);
  
  imageMode(CENTER);
  image(trophe, 452, 275, 80, 80);
  
  int propReussi = round(float(reussite_niveau[0]) / pack.getInt("nbNiveau") * 100);
  
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text(propReussi + "%", 452, 375);
  
  noFill();
  stroke(255);
  
  rect(50, 150, 480, 310);
  
  
  textSize(20);
  
  for(int i = 0; i < 2; i++){
    fill(0, 0, 0, 200);
    rect(i*300+600, 225, 250, 150); 
    image(horloge_icon, i*300+725, 270, 50, 50);
    
    fill(255);
    text("Prochainement", i*300+725, 330);
    
    
  }
  
  popMatrix();
  
  fill(30, 30, 30, 150);
  stroke(255);
  strokeWeight(4);
  rect(190, 550, 900, 35);
  
  
  fill(255,215,0);
  noStroke();
  rect(194, 554, map(XP, 0, pow(niv_joueur, 1.5)*10, 0, 892), 27);
  
  imageMode(CENTER);
  image(badgeNiveau, 190, 570, 70, 85);
  
  fill(0);
  textSize(50);
  textAlign(CENTER);
  
  text(niv_joueur, 190, 587);
  
  
  popMatrix();  
  
  

  if(mousePressed == true){
    if((mouseX/(float(height)/720)) > 50 && (mouseX/(float(height)/720)) < 530
    && (mouseY/(float(height)/720)) > 150 && (mouseX/(float(height)/720)) < 460){
      packID = 0;
      scene = 2;
      mousePressed = false;
    }    
    
  }
}



void afficheListeNiveau(int packID){
  
  JSONObject json = decryptJSONFile(liste_pack_json.getJSONObject(packID).getString("listeNiveauFile"));
  JSONArray niveaux_json = json.getJSONArray("listeNiveaux");
  
  pushMatrix();
  scale(float(height)/720);
  
  imageMode(CORNER);  
  tint(100, 100, 100, 200);
  image(loadImage(liste_pack_json.getJSONObject(packID).getString("miniature")), 0, 0, 1280, 720);
  
  noTint();
  imageMode(CENTER);
  
  image(titre_logo, 640, 60, 307, 71);
  
  textAlign(CENTER);
  textSize(50);
  
  for(int i = 0; i < niveaux_json.size(); i++){
    if(i < reussite_niveau[packID]){
      fill(70, 255, 150, 200);  
      
      
      
    }
    
    else{
      fill(255, 255, 255, 200);  
    }
    
    if(i == reussite_niveau[packID]){
      fill(0, 255, 255, 200);
    }
    
    stroke(0);
    
    rect((i%9)*125+80, round(i/9)*125+150, 110, 110, 10, 10, 10, 10);
    
    fill(0);
    text(i+1, (i%9)*125 + 135, round(i/9)*125 + 220);
    
  }
  
  
  
  
  popMatrix();
  
  
  if(mousePressed == true){
    if(mouseY > (150*float(height)/720)){
      if(mouseX > (80*float(height)/720) && mouseX < (1200*float(height)/720)){
        int caseX = round(mouseX/(125*float(height)/720));
        int caseY = round((mouseY-200*(float(height)/720))/(125*float(height)/720));
        
        niveauID = (caseY*9) + caseX-1;
        
        if(niveauID <= reussite_niveau[packID]){      
          niveau = new Niveau(decryptJSONFile(niveaux_json.getString((caseY*9) + caseX-1)));
          
          
          
          scene = 3;
          viseur = false;

        }
      }
      
    }   
    
  }
  
  
}

void afficheWinScreen(){
  fill(0, 0, 0, 150);   
  rect(0, 0, width, height);
  
  pushMatrix();
  scale(float(height)/720);
  
  fill(255);
  
  textAlign(LEFT);
  textSize(100);
  
  text("Bravo !", 100, 150);
  
  textSize(50);
  text("+30 ", 125, 260);
  image(coin_img, 270, 242, 40, 40);
  
  fill(30, 30, 30, 150);
  stroke(255);
  strokeWeight(4);
  rect(190, 350, 900, 35);
  
  //fill(255);
  //textSize(40);
  //textAlign(LEFT);
  //text("NIVEAU 3", 50, 520);
  
  fill(255,215,0);
  noStroke();
  rect(194, 354, map(XP, 0, pow(niv_joueur, 1.5)*10, 0, 892), 27);
  
  imageMode(CENTER);
  image(badgeNiveau, 190, 370, 70, 85);
  
  fill(0);
  textSize(50);
  textAlign(CENTER);
  
  text(niv_joueur, 190, 387);
  
  popMatrix();
}


void affichePause(){
  rectMode(CORNER);
  
  noStroke();
  fill(0, 0, 0, 100);  
  rect(0, 0, width, height);
  
  rectMode(CENTER);
  
  fill(255);
  stroke(0);
  
  rect(width/2, height/2, width/3, height/1.5);
  
  fill(0);
  
  textSize(50);
  textAlign(CENTER);
  
  text("EN PAUSE", width/2, height/3.5);
  
  
  
  stroke(0);
  strokeWeight(3);
  
  noFill();
  
  rect(width/2, height/2.5, width/4, height/10);
  
  fill(0);
  text("Reprendre", width/2, height/2.5+15);
  
  noFill();
  rect(width/2, height/2.5+height/8, width/4, height/10);
  
  fill(0);
  text("Niveaux", width/2, height/2.5+height/8 + 15);
  
  noFill();
  rect(width/2, height/2.5+height/4, width/4, height/10);
  
  fill(0);
  text("Menu principal", width/2, height/2.5+height/4 + 15);
  
  
  imageMode(CENTER);
  
  if(music_active)
    image(icon_son[0], width/2, height/2.5+height/4 + 130, 100, 100);
  else
    image(icon_son[1], width/2, height/2.5+height/4 + 130, 100, 100);
  
  
  imageMode(CORNER);
  textAlign(LEFT);
  rectMode(CORNER);
  
  if(mousePressed == true){
    if(mouseX > width/2-width/8 && mouseX < width/2+width/8){
      if(mouseY > height/2.5-height/20 && mouseY < height/2.5+height/20){
        pause = false;  
      }
      
      if(mouseY > height/2.5+height/8-height/20 && mouseY < height/2.5+height/8+height/20){
        pause = false;  
        scene = 2;
        mousePressed = false;
      }
      
      if(mouseY > height/2.5+height/4-height/20 && mouseY < height/2.5+height/4+height/20){
        pause = false;  
        scene = 1;
        mousePressed = false;
      }
      
    }
    if(mouseX > width/2 - 50 && mouseX < width/2 + 50){
      if(mouseY > height/2.5+height/4 + 130 - 50 && mouseY < height/2.5+height/4 + 130 + 50){
        music_active = !music_active;
        
        if(music_active)
          ankarus_theme.loop();
        else
          ankarus_theme.stop();
          
        sauvegarde();
        
        mousePressed = false;
      }   
      
      
    }
    
    
  }
  
  
}


void afficheTransition(){
  if(millis() - animationTransition < 1000 && !musicplay){
    introSound.play();
    musicplay = true;
    
  }

  if(millis() - animationTransition > 8000){
    transition = false;  
    noTint();
    musicplay = false;
    
    if(music_active)
      ankarus_theme.loop();
      
    thread("threadMouvement");
    return;
    
  }

  fill(0);
  
  rect(0, 0, width, height);  
  strokeWeight(3);
  stroke(20);
  
  for(int i = 0; i < height;i++){
    if(i%3 == 0)
      line(0, i*3, width, i*3);  
  }
  
  imageMode(CENTER);
  
  
  float taille = map(millis() - animationTransition, 0, 3000, 500, 600);
  float lum = 255;
  
  if(millis() - animationTransition < 1500){
    lum = map(millis() - animationTransition, 0, 1500, 0, 255);  
  }

  if(millis() - animationTransition > 3500){
    lum = map(millis() - animationTransition, 3500, 4500, 255, 0);  
  }  
  
  
  
  if(millis() - animationTransition > 4500){
    
    
    rectMode(CENTER);
    fill(0);
    stroke(255);
    
    rect(width/2, height/2, width-100, 100); 

    rectMode(CORNER);
    
    fill(255);
    rect(58, (height-100)/2+8, map(millis() - animationTransition, 4500, 8000, 0, width-100-16), 84);
    
    textSize(35);
    textAlign(CENTER);
    
    if(millis() - animationTransition > 6500){
      fill(0, 255, 0);
      
      
      if(randMsg == 1)
        text("Bonne chance!", width/2, height/2.5);
      else if(randMsg == 2)
        text("A toi de jouer!", width/2, height/2.5);
      else if(randMsg == 3)
        text("Que la fete commence!", width/2, height/2.5);
      else if(randMsg == 4)
        text("Et c'est partiii!", width/2, height/2.5);
      else if(randMsg == 5)
        text("On y va!", width/2, height/2.5);
      else
        text("Goooo!", width/2, height/2.5);
    }
    
    else if(millis() - animationTransition > 5500){
      text("Demarrage...", width/2, height/2.5);
    }
    
    else{
      text("Initialisation", width/2, height/2.5);
    }
    
  }  
  else{
    tint(lum);
    image(devistorm_logo, width/2, height/2, taille, taille);   
    
    
  }
  
  stroke(0);
  
}


void mousePressed(){
  
  if(!viseur && scene == 3 && !pause && !niveau.win && niveau.nbExploRestant > 0){
    viseurPosX = mouseX;
    viseurPosY = mouseY;
    
    viseur = true;
  }
  
  //niveau.creeExplosion(posX, posY);
  
  
  
 
}

//void onCreate(){
//    MobileAds.initialize(getContext(), "ca-app-pub-3778298952636594~5139926984");
    
    
//}

//void mouseReleased(){
//  if(viseur){
//    float posX = mouseX;
//    float posY = mouseY;
    
//    PVector vecteurTire = new PVector(viseurPosX - posX, viseurPosY - posY).mult(0.3);
    
//    if(vecteurTire.mag() > 16)vecteurTire.setMag(16);
    
//    niveau.balle.setForce(vecteurTire);   
//    niveau.nbExploRestant--;
//  }
  
//  viseur = false;  
  
//}
