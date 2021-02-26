import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isTablet(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 600 || kIsWeb;

bool isAndroid(BuildContext context) => Theme.of(context).platform == TargetPlatform.android;

void prefsSet(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String> prefsGet(String key) {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  return _prefs.then((SharedPreferences prefs) {
    return (prefs.getString(key) ?? "");
  });
}

void securitySet(String key, String value) async {
  final storage = new FlutterSecureStorage();
  await storage.write(key: key, value: value);
}

Future<String> securityGet(String key) {
  final storage = new FlutterSecureStorage();
  return storage.read(key: key);
}

String validateEmail(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Your username is required";
  } else if (!regex.hasMatch(value)) {
    _msg = "Please provide a valid emal address";
  }
  return _msg;
}

TValue case2<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
      TValue defaultValue = null,
    ]) {
  if (!branches.containsKey(selectedOption)) {
    return defaultValue;
  }

  return branches[selectedOption];
}

extension Neumorphism on Widget {
  addNeumorphism({
    double borderRadius = 10.0,
    Offset offset = const Offset(5, 5),
    double blurRadius = 10,
    Color topShadowColor = Colors.white60,
    Color bottomShadowColor = const Color(0x26234395),
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: blurRadius,
            color: topShadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}