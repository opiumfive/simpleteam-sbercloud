
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:flutter/foundation.dart';
import 'package:sbercloud_flutter/models/cloud_eye_models.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

class MainProvider with ChangeNotifier {

  List<Metric> _metrics;

  List<Metric> get metrics => _metrics;

  void setMetrics(List<Metric> metrics) {
    _metrics = metrics;
    notifyListeners();
  }
}