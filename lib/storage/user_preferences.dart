
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("id", user.id);
    prefs.setString("name", user.name);

    return prefs.commit();
  }
  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("id");
    String visibleName = prefs.getString("name");

    if (userId == null || userId.isEmpty) return null;

    return User(id: userId, name: visibleName);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("id");
    prefs.remove("name");
    prefs.remove("token");
  }

  Future<bool> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    return prefs.commit();
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}