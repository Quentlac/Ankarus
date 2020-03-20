////////PARTIE SPECIAL UNIQUEMENT VALABLE POUR ANDROID
////////COMMENTER POUR PC

////import android.app.Activity;
////import android.content.Context;
////import android.os.Vibrator;
////import android.content.Intent;
//import cassette.audiofiles.*;

//import android.os.Environment;
//import android.content.SharedPreferences;
//import android.content.Context;
//import android.media.MediaPlayer;
//import android.app.Activity;
//import android.content.res.*;


//SharedPreferences sauvegarde_shared;
//Context context;

//void init(){
//  Activity act = this.getActivity();    
//  context = getContext();
  
 
//}



//void vibration(){
//  //vibra.vibrate(70); 

//}

//void getSauvegarde(){
//  sauvegarde_shared = context.getSharedPreferences("sauvegarde", 0);
  

//  coin = sauvegarde_shared.getInt("coin", 0); 
//  XP = sauvegarde_shared.getInt("XP", 0);
//  niv_joueur = sauvegarde_shared.getInt("niv_joueur", 0);
//  music_active = sauvegarde_shared.getBoolean("music", true); 
//  String str_reussite = sauvegarde_shared.getString("reussite_niveau", "{ reussite: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}");
  
//  JSONObject json_reussite = parseJSONObject(str_reussite);
//  JSONArray array_reussite = json_reussite.getJSONArray("reussite");
  
//  for(int i = 0; i < array_reussite.size(); i++){
//    reussite_niveau[i] = array_reussite.getInt(i);  
   
//  }  
   
//}

//void sauvegarde(){

//  SharedPreferences.Editor editeur_save = sauvegarde_shared.edit();

//  editeur_save.putInt("coin", coin);
//  editeur_save.putInt("XP", XP);
//  editeur_save.putInt("niv_joueur", niv_joueur);
//  editeur_save.putBoolean("music", music_active);
  
//  String save_reussite = "{reussite : [";
  
//  for(int i = 0; i < 10;i++){
//    save_reussite += reussite_niveau[i] + ", ";  
    
//  }
  
//  save_reussite += "]}";
  
//  editeur_save.putString("reussite_niveau", save_reussite);

//  editeur_save.commit();
  
  
  
  
//}


//JSONObject decryptJSONFile(String filename){
  
//  return loadJSONObject(filename);
  
//  //try{
  
//  //  Key cleSecret = new SecretKeySpec(cleAES.getBytes(), "AES");
    
//  //  Cipher cipher;
//  //  cipher = Cipher.getInstance("AES");
//  //  cipher.init(Cipher.DECRYPT_MODE, cleSecret);
    
//  //  byte[] inputBytes = loadBytes(filename); 
//  //  byte[] outputBytes = cipher.doFinal(inputBytes);
        
//  //  JSONObject json_decrypt = parseJSONObject(new String(outputBytes));  
        
//  //  return json_decrypt;
  
    
//  //} catch (NoSuchAlgorithmException e) {
//  //  println(e);
//  //} catch (NoSuchPaddingException e) {
//  //  println(e);
//  //} catch (InvalidKeyException e) {
//  //  println(e);
//  //} catch (IllegalBlockSizeException e) {
//  //  println(e);
//  //} catch (BadPaddingException e) {
//  //  println(e);
//  //}   
  
//  //return null;
//}


//void encryptJSONFile(JSONObject json_file, String filename){
//  saveJSONObject(json_file, filename);
  
//  //try{
  
//  //  Key cleSecret = new SecretKeySpec(cleAES.getBytes(), "AES");
    
//  //  Cipher cipher;
//  //  cipher = Cipher.getInstance("AES");
//  //  cipher.init(Cipher.ENCRYPT_MODE, cleSecret);
    
//  //  byte[] inputBytes = loadBytes(filename); 
//  //  byte[] outputBytes = cipher.doFinal(inputBytes);
        
//  //  saveBytes(filename , outputBytes);
  
    
//  //} catch (NoSuchAlgorithmException e) {
//  //  println(e);
//  //} catch (NoSuchPaddingException e) {
//  //  println(e);
//  //} catch (InvalidKeyException e) {
//  //  println(e);
//  //} catch (IllegalBlockSizeException e) {
//  //  println(e);
//  //} catch (BadPaddingException e) {
//  //  println(e);
//  //}   
  
//}
