import 'package:sbercloud_flutter/models/models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../const.dart';

part 'api.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
//flutter build apk --split-per-abi

@RestApi(baseUrl: API_BASE)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) {
    dio.options = BaseOptions(receiveTimeout: 15000, connectTimeout: 15000);
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return _RestClient(dio, baseUrl: baseUrl);
  }

  @POST("/auth")
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET("/auth")
  Future<User> user(@Header("X-Access-Token") String token);
}