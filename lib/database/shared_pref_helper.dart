import 'package:shared_preferences/shared_preferences.dart';

//this helper class is for retrieving and updating data to Shared Preferences
class SharedPrefHelper {
  //retrieve username from shared preferences
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

// retrieve user state/division from shared preferences
  static Future<String?> getUserState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userState');
  }

// retrieve user township mimu from shared preferences
  static Future<String?> getUserTspMimu() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userTspMimu');
  }

// retrieve user township eho from shared preferences
  static Future<String?> getUserTspEho() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userTspEho');
  }

// retrieve user village from shared preferences
  static Future<String?> getUserVil() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userVil');
  }

  // retrieve user area from shared preferences
  static Future<String?> getUserArea() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userArea');
  }

//retrieve user region from shared preferences
  static Future<String?> getUserRegion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userRegion');
  }
}
