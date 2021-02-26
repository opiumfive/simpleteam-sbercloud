import 'dart:convert';

import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:sbercloud_flutter/models/server_error.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:sbercloud_flutter/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

enum Status {
  NotLoggedIn,
  LoggedIn,
  Authenticating,
}

class AuthApiUsecase with ChangeNotifier {
  Dio dio;
  RestClient restClient;

  Status _loggedInStatus = Status.NotLoggedIn;
  Status get loggedInStatus => _loggedInStatus;

  AuthApiUsecase() {
    dio = new Dio();
    restClient = new RestClient(dio, baseUrl: API_BASE_IAM);
  }

  Future<BaseModel<User>> login(String login, String password) async {
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    LoginResponse response;
    try {
      const _extra = <String, dynamic>{};
      final queryParameters = <String, dynamic>{};
      final _data = <String, dynamic>{};
      _data.addAll(LoginRequest(login: login, password: password).toJson() ?? <String, dynamic>{});
      final _result = await dio.request<Map<String, dynamic>>('/v3/auth/tokens',
          queryParameters: queryParameters,
          options: RequestOptions(
              method: 'POST',
              headers: <String, dynamic>{},
              extra: _extra,
              baseUrl: API_BASE_IAM),
          data: _data);
      List<String> tokenHeaders = _result.headers['x-subject-token'];
      final value = LoginResponse.fromJson(_result.data);
      response = value;

      if (response != null && response.token != null && response.token.user != null
          && tokenHeaders != null && tokenHeaders.isNotEmpty) {
        String token = tokenHeaders.first;

        UserPreferences userPreferences = UserPreferences();
        userPreferences.saveUser(response.token.user);
        userPreferences.saveToken(token);
        _loggedInStatus = Status.LoggedIn;
        notifyListeners();
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
      }
      return BaseModel()..data = response.token.user;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
  }
}