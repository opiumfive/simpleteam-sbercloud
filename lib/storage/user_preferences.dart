
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

  Future<bool> saveProject(UserProject project) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("p_id", project.id);
    prefs.setString("p_name", project.name);

    return prefs.commit();
  }
  Future<UserProject> getProject() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString("p_id");
    String name = prefs.getString("p_name");

    return UserProject(id: id, name: name);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("id");
    prefs.remove("name");
    prefs.remove("token");
    prefs.remove("p_id");
    prefs.remove("p_name");
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