
import 'package:sbercloud_flutter/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("uuid", user.uuid);
    prefs.setString("employee_uuid", user.employee_uuid);
    prefs.setString("auth_login", user.auth_login);
    prefs.setString("visible_name", user.visible_name);

    return prefs.commit();
  }
  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("uuid");
    String empId = prefs.getString("employee_uuid");
    String authLogin = prefs.getString("auth_login");
    String visibleName = prefs.getString("visible_name");

    if (userId == null || userId.isEmpty) return null;

    return User(uuid: userId, employee_uuid: empId, auth_login: authLogin, visible_name: visibleName);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("uuid");
    prefs.remove("employee_uuid");
    prefs.remove("auth_login");
    prefs.remove("visible_name");
    prefs.remove("phone");
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

  Future<bool> savePhone(String phone) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("phone", phone);
    return prefs.commit();
  }

  Future<String> getPhone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("phone");
    return token;
  }
}