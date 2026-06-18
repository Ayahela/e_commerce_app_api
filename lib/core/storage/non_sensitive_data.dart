import 'package:shared_preferences/shared_preferences.dart';

class NonSensitiveData {
  static Future<void> saveProfileImage(String imageUrl)async{
    final pref=await SharedPreferences.getInstance();
    await pref.setString("ProfileImage", imageUrl);
  }
  static Future<String?> getProfileImage()async{
    final pref=await SharedPreferences.getInstance();
    return pref.getString("ProfileImage");
  }
  static Future<void> deleteProfileImage()async{
    final pref=await SharedPreferences.getInstance();
    await pref.remove("ProfileImage");
  }
  static Future<void> addToCart (int productId)async{
    final pref=await SharedPreferences.getInstance();
    var cartIds= pref.getStringList("cart")?? [];
    if(!cartIds.contains(productId.toString())){
      cartIds.add(productId.toString());
      pref.setStringList("cart",cartIds);
    }
  }
  static Future<List<String>> getCartIds ()async{
    final pref=await SharedPreferences.getInstance();
    return pref.getStringList("cart") ?? [];
  }
  static Future<void> deleteCart (int productId)async{
    final pref=await SharedPreferences.getInstance();
    var cartIds = pref.getStringList("cart")??[];
    cartIds.remove(productId.toString());
    pref.setStringList("cart", cartIds);
  }
}