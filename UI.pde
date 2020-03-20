//Interface utilisateur

public interface SetEventBouton{
  public void clique();
  
  
}

public interface SetEventPopup{
  public void oui();
  public void non();
  
}


class UI{
  
  //la liste des boutons
  
 
   BoutonImage niveau_suiv = new BoutonImage(980, 550, 150, 75, loadImage("Images/next.png"), false, new SetEventBouton(){
    
    public void clique(){
      println("testtt");
      JSONObject json = decryptJSONFile(liste_pack_json.getJSONObject(packID).getString("listeNiveauFile"));
      JSONArray niveaux_json = json.getJSONArray("listeNiveaux");
      
      niveauID++;
      niveau = new Niveau(decryptJSONFile(niveaux_json.getString(niveauID))); 
      
    }   
    
   
   });
   
   BoutonImage replay_menu = new BoutonImage(250, 550, 160, 160, loadImage("Images/replay.png"), false, new SetEventBouton(){
    
    public void clique(){

      niveau.win = false;

      JSONObject json = decryptJSONFile(liste_pack_json.getJSONObject(packID).getString("listeNiveauFile"));
      JSONArray niveaux_json = json.getJSONArray("listeNiveaux");
 
      niveau = new Niveau(decryptJSONFile(niveaux_json.getString(niveauID)));
      
      
    }   
    
   });
   
   
   
   BoutonImage replay = new BoutonImage(50, 50, 100, 100, loadImage("Images/replay.png"), false, new SetEventBouton(){
    
    public void clique(){
      niveau.respawnBalle();
      niveau.nbExploRestant = niveau.nbExploMax;
      viseur = false;
      
    }   
    
   });
   
   BoutonImage pause_btn = new BoutonImage(1200, 60, 60, 60, loadImage("Images/pause.png"), false, new SetEventBouton(){
    
    public void clique(){
      
      pause = true;
      
    }   
    
   });
   
  
  //###########################################
  //FIN DE LA DECLARATION DES BOUTONS
  
  
  CompteurExplosion compteurExplo = new CompteurExplosion(100, 600, 0, color(255, 0, 0));
  
  public void collisionsBoutons(){
    if(niveau.win){
      niveau_suiv.collision();
      replay_menu.collision();
      
    }
   
      
    else if(scene == 3 && !pause){
      replay.collision();  
      pause_btn.collision();
    }
    


  }
  
  public void affichesBoutons(){
    if(niveau.win){
      niveau_suiv.affiche();
      replay_menu.affiche();
    }
    
    else if(scene == 3 && !pause){
      replay.affiche();  
      pause_btn.affiche();
    }
    
    
  }
  
  
  public void affichage(){
    
    
    pushMatrix();
    scale(float(height)/720);
    
    affichesBoutons();
    
    
    compteurExplo.setRestant(niveau.nbExploRestant);
    
    if(!niveau.win){
      if(scene == 3 && !pause)
        compteurExplo.affiche();
    }
      
    popMatrix();
      
    
  }
  
  
  
  private abstract class Bouton{
    protected float posX, posY;
  
    protected float w, h;    
    
    public SetEventBouton event;    
    
    abstract void affiche();
    
    boolean active = false;
      
    protected void collision(){     
       if((mouseX/(float(height)/720)) > this.posX - this.w/2 && (mouseX/(float(height)/720)) < this.posX + this.w/2
       && (mouseY/(float(height)/720)) > this.posY - this.h/2 && (mouseY/(float(height)/720)) < this.posY + this.h/2){
         if(mousePressed){
           event.clique();
           viseur = false;
           mousePressed = false; //on remet la variable à faux pour éviter que le reste du programme croit qu'on clique pour poser quelques chose
         }
       }   
    }
    
    public void setActive(boolean a){
      this.active = a;
    }
    
    
  }
  
  public class BoutonTexte extends Bouton{
    
    
    private String texte = "";
    

    BoutonTexte(float posX, float posY, float w, float h, String texte, SetEventBouton e){
      
      this.posX = posX;
      this.posY = posY;
      
      this.w = w;
      this.h = h;
      
      this.texte = texte;
    
      this.event = e;
      
    }
    
    public void affiche(){
      noFill();
 
      stroke(255);
      
      strokeWeight(3);
      
      rect(this.posX, this.posY, this.w, this.h);
      
      textAlign(CENTER);
      textSize(20);
      text(this.texte, this.posX+this.w/2, this.posY+this.h/1.4);
      
    
    }    
  }
  
  public class BoutonImage extends Bouton{
    
    
    private PImage image;
    boolean cadre = false;
    
    

    BoutonImage(float posX, float posY, float w, float h, PImage image, boolean cadre, SetEventBouton e){
      
      this.posX = posX;
      this.posY = posY;
      
      this.w = w;
      this.h = h;
      
      this.image = image;
    
      this.event = e;
      
      this.cadre = cadre;
      
    }
    
    public void affiche(){
      if(this.cadre){
        fill(255,255,255,50);
        
        if(this.active) stroke(0);
        else stroke(255);
        
        strokeWeight(3);
        
        rectMode(CENTER);
        rect(this.posX, this.posY, this.w, this.h);         
      }
      
      image(this.image, this.posX, this.posY, this.w, this.h);
      
    
    }    
  }
  
  public class CompteurExplosion{
    private float posX, posY;
    
    private int nombreRestant = 5;
    private int nombreDepart = 1;
    
    private color couleur = color(255, 0, 0);
    
    CompteurExplosion(float posX, float posY, int nombreDepart, color c){
      this.nombreDepart = nombreDepart; 
      this.posX = posX;
      this.posY = posY;
      
      this.couleur = c;
      
    }
    
    
    
    public void affiche(){
      noFill(); 
      strokeWeight(5);
      
      stroke(255);
      ellipse(this.posX, this.posY, 120, 160);
      
      strokeWeight(18);
      
      for(int i = 0; i < nombreDepart;i++){
        
        
        
        
        if(i < nombreRestant)stroke(couleur);
        else noStroke();
        
        arc(this.posX, this.posY, 120, 160, radians(i * (360 / nombreDepart) + 15), radians(i * (360 / nombreDepart) + 15) + radians(360/nombreDepart - 30));
        
      }
      
      textAlign(CENTER);
      //textFont(compteur_font);
      fill(255);
      textSize(60);
      text(nombreRestant, this.posX, this.posY+20);
      
      
    }
    
    public void setRestant(int n){
      this.nombreRestant = n;  
    }
    
    public void setTotal(int n){
      this.nombreDepart = n;  
    }
    
    
    
  }
  
  
  
  
}
