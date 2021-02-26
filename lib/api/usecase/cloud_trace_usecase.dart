import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:sbercloud_flutter/models/server_error.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:sbercloud_flutter/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

class CloudTraceUsecase with ChangeNotifier {

  Dio dio;
  RestClient restClient;

  CloudTraceUsecase() {
    dio = new Dio();
    restClient = new RestClient(dio, baseUrl: API_BASE_CTS);
  }

}