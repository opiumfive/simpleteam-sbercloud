import 'package:sbercloud_flutter/models/models.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

class MainProvider with ChangeNotifier {

}