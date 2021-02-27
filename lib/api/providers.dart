
import 'package:flutter/material.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:flutter/foundation.dart';
import 'package:sbercloud_flutter/models/cloud_eye_models.dart';
import 'package:sbercloud_flutter/ui/main/chart_data.dart';

class UserProvider with ChangeNotifier {
  User _user = new User();
  UserDetail _detail;

  User get user => _user;

  UserDetail get detail => _detail;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setDetails(UserDetail detail) {
    _detail = detail;
    notifyListeners();
  }
}

class MainProvider with ChangeNotifier {

  List<Metric> _metrics;
  List<MetricAlarm> _alarms;
  DateTimeRange _range = DateTimeRange(start: DateTime.now().subtract(Duration(hours: 24)), end: DateTime.now());
  int _interval = 3600;
  Map<String, List<ChartDataSeries>> chartDataCache = Map();
  Set<String> excludedMetrics = Set();
  List<Resource> resources;

  List<Metric> get metrics => _metrics;
  List<MetricAlarm> get alarms => _alarms;
  DateTimeRange get range => _range;
  int get interval => _interval;

  void setRange(DateTimeRange range) {
    _range = range;
    notifyListeners();
  }

  void setInterval(int interval) {
    _interval = interval;
    notifyListeners();
  }

  void setMetrics(List<Metric> metrics) {
    _metrics = metrics;
    notifyListeners();
  }

  void setAlarms(List<MetricAlarm> alarms) {
    _alarms = alarms;
    notifyListeners();
  }
}