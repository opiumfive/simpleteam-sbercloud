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

class CloudEyeUsecase with ChangeNotifier {

  Dio dio;
  RestClient restClient;

  CloudEyeUsecase() {
    dio = new Dio();
    restClient = new RestClient(dio, baseUrl: API_BASE_CES);
  }

  Future<BaseModel<List<Metric>>> metrics() async {
    MetricsResponse response;
    UserPreferences userPreferences = UserPreferences();
    String token = await userPreferences.getToken();
    UserProject project = await userPreferences.getProject();
    try {
      response = await restClient.eyeMetrics(token, project.id);

      if (response != null && response.metrics != null) {
        return BaseModel()..data = response.metrics;
      } else {
        return BaseModel()..data = List.empty();
      }

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
  }

  Future<BaseModel<List<Resource>>> quotas() async {
    QuotasResponse response;
    UserPreferences userPreferences = UserPreferences();
    String token = await userPreferences.getToken();
    UserProject project = await userPreferences.getProject();
    try {
      response = await restClient.eyeQuotas(token, project.id);

      if (response != null && response.quotas != null && response.quotas.resources != null) {
        return BaseModel()..data = response.quotas.resources;
      } else {
        return BaseModel()..data = List.empty();
      }

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
  }

  Future<BaseModel<List<MetricAlarm>>> alarmRules() async {
    AlarmRulesResponse response;
    UserPreferences userPreferences = UserPreferences();
    String token = await userPreferences.getToken();
    UserProject project = await userPreferences.getProject();
    try {
      response = await restClient.eyeAlarmRules(token, project.id);

      if (response != null && response.metric_alarms != null) {
        return BaseModel()..data = response.metric_alarms;
      } else {
        return BaseModel()..data = List.empty();
      }

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
  }

  // filter is max/min/average/sum/variance
  Future<BaseModel<List<Datapoint>>> metricData(Metric metric, DateTimeRange dateTimeRange, int periodSec, {String filter = "min"}) async {
    MetricDataResponse response;
    UserPreferences userPreferences = UserPreferences();
    String token = await userPreferences.getToken();
    UserProject project = await userPreferences.getProject();
    try {
      Map<String, dynamic> query = {
        "namespace": metric.namespace,
        "metric_name": metric.metric_name,
        "period": periodSec,
        "from": dateTimeRange.start.toUtc().millisecondsSinceEpoch,
        "to": dateTimeRange.end.toUtc().millisecondsSinceEpoch,
        "filter": filter
      };
      int i = 0;
      metric.dimensions.forEach((element) {
        query["dim.$i"] = element.name + "," + element.value;
        i++;
      });

      response = await restClient.eyeMetricData(token, project.id, query);

      if (response != null && response.datapoints != null) {
        return BaseModel()..data = response.datapoints;
      } else {
        return BaseModel()..data = List.empty();
      }

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BaseModel()..setException(ServerError.withError(error: error));
    }
  }

}