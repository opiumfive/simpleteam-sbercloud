import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:sbercloud_flutter/models/cloud_eye_models.dart';
import 'package:sbercloud_flutter/models/server_error.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:sbercloud_flutter/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

class ProfileUsecase with ChangeNotifier {

  Dio dio;
  RestClient restClient;

  ProfileUsecase() {
    dio = new Dio();
    restClient = new RestClient(dio, baseUrl: API_BASE_IAM);
  }

  Future<BaseModel<UserDetail>> user() async {
    UserDetailResponse response;
    UserPreferences userPreferences = UserPreferences();
    User user = await userPreferences.getUser();
    String token = await userPreferences.getToken();

    try {
      response = await restClient.user(token, user.id);

      if (response.user != null) {
        return BaseModel()..data = response.user;
      } else {
        return BaseModel()..setException(new Exception("User is null"));
      }

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
  }

}