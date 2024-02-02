import 'package:get/get.dart';
import 'package:petvillage/screen/splash/view/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConstString {
  static const String token = "PetToken";
  static const String email = "PetEmail";
  static const String isLogin = "PetIsLogin";
  static const String id = "id";
  static const String name = "PetName";

  // Local Storage Function

  static Future<void> setLogin() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setBool(ConstString.isLogin, true);
  }

  static Future<bool?> getLogin(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getBool(key);
  }

  static Future<void> setToken({required String token}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(ConstString.token, token);
  }

  static Future<String?> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(ConstString.token);
  }

  static Future<void> clearToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.remove(ConstString.token);
  }

  static Future<void> setEmail({required String email}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(ConstString.email, email);
  }

  static Future<String?> getEmail() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(ConstString.email);
  }

  static Future<void> setId({required String id}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(ConstString.id, id);
  }

  static Future<String?> getId() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(ConstString.id);
  }

  static Future<void> setName({required String name}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString(ConstString.name, name);
  }

  static Future<String?> getName() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(ConstString.name);
  }

  static Future<void> clearAll() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
    Get.offAll(() => const SplashView());
  }

  //EndPoints
  static const String baseUrl = "https://petvillagedubai.com";
  static const String products =
      "$baseUrl/wc-api/v3/products?filter[category]=";
  static const String relatedItems = "$baseUrl/wc-api/v3/products??include=";
  static const String reviews =
      "$baseUrl/wp-json/wc/v2/products/{---}/reviews?review=";
  static const String addOrder = "$baseUrl/wp-json/wc/v3/orders";
  static const myOrder = "$baseUrl/wp-json/wc/v3/orders?customer=";
  static const searchProduct = "$baseUrl/wc-api/v3/products?search=";

  //Files

  static const String petLogo = "assets/icon/petLogo.png";
  static const String home1 =
      '''https://petvillagedubai.com/wp-content/uploads/2022/12/ricky-jpg.webp''';
  static const String home2 =
      "https://petvillagedubai.com/wp-content/uploads/2022/12/ricky-2-jpg.webp";
  static const String cat = "assets/icon/cat.png";
  static const String dog = "assets/icon/dog.png";
  static const String bird = "assets/icon/birds.png";
  static const String smallPet = "assets/icon/small.png";
  static const String fish = "assets/icon/aquatic.png";
}
