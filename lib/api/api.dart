import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../const.dart';

part 'api.g.dart';

//команда генерации кода - flutter pub run build_runner build --delete-conflicting-outputs
//команда для билда релизной апк - flutter build apk --split-per-abi
//команда для запуска релизной апк - flutter run --release

@RestApi(baseUrl: API_HOST)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) {
    dio.options = BaseOptions(receiveTimeout: 15000, connectTimeout: 15000);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return _RestClient(dio, baseUrl: baseUrl);
  }

  @POST("/v3/auth/tokens")
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  //@GET("/auth")
  //Future<User> user(@Header("X-Access-Token") String token);
}