//PARTIE SPECIAL UNIQUEMENT VALABLE POUR PC
//COMMENTER POUR ANDROID
import processing.sound.*;



void vibration(){}
void init(){}


void getSauvegarde(){
  
  try{
    JSONObject save_json = decryptJSONFile("save.json");  
    
    if(save_json != null){
      JSONArray reussiteJSON = save_json.getJSONArray("reussiteNiveau");    
      
      for(int i = 0; i < reussiteJSON.size(); i++){
        reussite_niveau[i] = reussiteJSON.getInt(i);  
        
      }
      
      coin = save_json.getInt("coin");
      XP = save_json.getInt("XP");
      niv_joueur = save_json.getInt("niveauJoueur");
      
      music_active = save_json.getBoolean("music");
      
      
      
    }
  }
  catch(IllegalArgumentException e){
    
  }




}

void sauvegarde(){
  println("SAUVEGARDE ");
  JSONObject json_template = new JSONObject();
    
  JSONArray reussiteJSON = new JSONArray();
  
  for(int i = 0; i < reussite_niveau.length; i++){
    reussiteJSON.setInt(i, reussite_niveau[i]);  
  }
  
  json_template.setJSONArray("reussiteNiveau", reussiteJSON);
  
  json_template.setInt("coin", coin);
  json_template.setInt("XP", XP);
  json_template.setInt("niveauJoueur", niv_joueur);
  json_template.setBoolean("music", music_active);
  
  encryptJSONFile(json_template, "save.json");  
  
  
  
}

JSONObject decryptJSONFile(String filename){
  
  return loadJSONObject(filename);
  
  //try{
  
  //  Key cleSecret = new SecretKeySpec(cleAES.getBytes(), "AES");
    
  //  Cipher cipher;
  //  cipher = Cipher.getInstance("AES");
  //  cipher.init(Cipher.DECRYPT_MODE, cleSecret);
    
  //  byte[] inputBytes = loadBytes(filename); 
  //  byte[] outputBytes = cipher.doFinal(inputBytes);
        
  //  JSONObject json_decrypt = parseJSONObject(new String(outputBytes));  
        
  //  return json_decrypt;
  
    
  //} catch (NoSuchAlgorithmException e) {
  //  println(e);
  //} catch (NoSuchPaddingException e) {
  //  println(e);
  //} catch (InvalidKeyException e) {
  //  println(e);
  //} catch (IllegalBlockSizeException e) {
  //  println(e);
  //} catch (BadPaddingException e) {
  //  println(e);
  //}   
  
  //return null;
}


void encryptJSONFile(JSONObject json_file, String filename){
  saveJSONObject(json_file, filename);
  
  //try{
  
  //  Key cleSecret = new SecretKeySpec(cleAES.getBytes(), "AES");
    
  //  Cipher cipher;
  //  cipher = Cipher.getInstance("AES");
  //  cipher.init(Cipher.ENCRYPT_MODE, cleSecret);
    
  //  byte[] inputBytes = loadBytes(filename); 
  //  byte[] outputBytes = cipher.doFinal(inputBytes);
        
  //  saveBytes(filename , outputBytes);
  
    
  //} catch (NoSuchAlgorithmException e) {
  //  println(e);
  //} catch (NoSuchPaddingException e) {
  //  println(e);
  //} catch (InvalidKeyException e) {
  //  println(e);
  //} catch (IllegalBlockSizeException e) {
  //  println(e);
  //} catch (BadPaddingException e) {
  //  println(e);
  //}   
  
}
