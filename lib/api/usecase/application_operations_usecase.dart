import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:sbercloud_flutter/models/server_error.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:sbercloud_flutter/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

// use case for Application Operations Management, not used now, just for future use
class ApplicationOperationsUsecase with ChangeNotifier {

  Dio dio;
  RestClient restClient;

  ApplicationOperationsUsecase() {
    dio = new Dio();
    restClient = new RestClient(dio, baseUrl: API_BASE_AOM);
  }

}