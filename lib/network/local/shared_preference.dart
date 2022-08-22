import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;
  static init()async{
    sharedPreferences =await SharedPreferences.getInstance();
  }

//Save Data To SharedPreferences
  static Future<bool> saveData({
  required String key,
    required dynamic value,
})async{
    if(value is String ) return await sharedPreferences!.setString(key, value);
    if(value is int ) return await sharedPreferences!.setInt(key, value);
    if(value is bool ) return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

//Get Data From SharedPreferences
static dynamic getDatat({
  required String key,
}){
    return sharedPreferences!.get(key);
}
}