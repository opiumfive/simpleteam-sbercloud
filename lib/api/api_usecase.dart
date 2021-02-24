import 'dart:convert';

import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/models.dart';
import 'package:sbercloud_flutter/models/server_error.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:sbercloud_flutter/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Status {
  NotLoggedIn,
  LoggedIn,
  Authenticating,
}

class ApiUsecase with ChangeNotifier {
  Dio dio;
  RestClient restClient;

  Status _loggedInStatus = Status.NotLoggedIn;
  Status get loggedInStatus => _loggedInStatus;

  ApiUsecase() {
    dio = new Dio();
    restClient = new RestClient(dio);
  }

  Future<BaseModel<User>> login(String login, String password) async {
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    LoginResponse response;
    User userResp;
    try {
      response = await restClient.login(LoginRequest(login, password));
      if (response != null) {
        String token = response.access_token;


        userResp = await restClient.user(token);
        if (userResp != null) {
          UserPreferences userPreferences = UserPreferences();
          userPreferences.saveUser(userResp);
          userPreferences.saveToken(token);
          userPreferences.savePhone(login);
          _loggedInStatus = Status.LoggedIn;
          notifyListeners();
        }
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
      }
      return BaseModel()..data = userResp;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
  }
}