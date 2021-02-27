import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:sbercloud_flutter/models/cloud_eye_models.dart';

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

  @GET("/v3/projects")
  Future<void> projects(@Header("X-Auth-Token") String token);
  /* Output example
  {
    "projects": [
        {
            "domain_id": "65382450e8f64ac0870cd180d14e684b",
            "is_domain": false,
            "parent_id": "65382450e8f64ac0870cd180d14e684b",
            "name": "project_name",
            "description": "",
            "links": {
                "next": null,
                "previous": null,
                "self": "https://www.example.com/v3/projects/a4a5d4098fb4474fa22cd05f897d6b99"
            },
            "id": "a4a5d4098fb4474fa22cd05f897d6b99",
            "enabled": true
        }
    ],
    "links": {
        "next": null,
        "previous": null,
        "self": "https://www.example.com/v3/projects"
    }
}
   */

  @GET("/V1.0/{project_id}/metrics")
  Future<MetricsResponse> eyeMetrics(@Header("X-Auth-Token") String token, @Path() String project_id);

  @GET("/V1.0/{project_id}/quotas")
  Future<QuotasResponse> eyeQuotas(@Header("X-Auth-Token") String token, @Path() String project_id);

  @GET("/V1.0/{project_id}/alarms")
  Future<AlarmRulesResponse> eyeAlarmRules(@Header("X-Auth-Token") String token, @Path() String project_id);

  @GET("/V1.0/{project_id}/metric-data")
  Future<MetricDataResponse> eyeMetricData(@Header("X-Auth-Token") String token, @Path() String project_id, @Queries() Map<String, dynamic> queries);
}