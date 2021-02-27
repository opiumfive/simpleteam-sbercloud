import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../const.dart';
part 'cloud_eye_models.g.dart';

@JsonSerializable()
class AlarmRulesResponse {
  List<MetricAlarm> metric_alarms;
  Metadata meta_data;

  AlarmRulesResponse({this.meta_data, this.metric_alarms});

  factory AlarmRulesResponse.fromJson(Map<String, dynamic> json) => _$AlarmRulesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmRulesResponseToJson(this);

}

@JsonSerializable()
class MetricAlarm {
  String alarm_name;
  String alarm_description;
  Metric metric;
  bool alarm_enabled;
  int alarm_level;
  bool alarm_action_enabled;
  String alarm_id;
  int update_time;
  String alarm_state;
  Condition condition;

  MetricAlarm();

  factory MetricAlarm.fromJson(Map<String, dynamic> json) => _$MetricAlarmFromJson(json);
  Map<String, dynamic> toJson() => _$MetricAlarmToJson(this);

}

@JsonSerializable()
class Condition {
  int period;
  String filter;
  String comparison_operator;
  int value;
  String unit;
  int count;

  Condition();

  factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);
  Map<String, dynamic> toJson() => _$ConditionToJson(this);

}

@JsonSerializable()
class QuotasResponse {
  Quotas quotas;

  QuotasResponse({this.quotas});

  factory QuotasResponse.fromJson(Map<String, dynamic> json) => _$QuotasResponseFromJson(json);
  Map<String, dynamic> toJson() => _$QuotasResponseToJson(this);

}

@JsonSerializable()
class Quotas {
  List<Resource> resources;

  Quotas({this.resources});

  factory Quotas.fromJson(Map<String, dynamic> json) => _$QuotasFromJson(json);
  Map<String, dynamic> toJson() => _$QuotasToJson(this);

}

@JsonSerializable()
class Resource {
  String type;
  String unit;
  int used;
  int quota;

  Resource({this.type, this.unit, this.used, this.quota});

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);
  Map<String, dynamic> toJson() => _$ResourceToJson(this);

}

@JsonSerializable()
class MetricsResponse {
  List<Metric> metrics;
  Metadata meta_data;

  MetricsResponse({this.metrics, this.meta_data});

  factory MetricsResponse.fromJson(Map<String, dynamic> json) => _$MetricsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MetricsResponseToJson(this);

}

@JsonSerializable()
class Metric {
  String namespace;
  String unit;
  String metric_name;
  List<Dimension> dimensions;

  Metric({this.namespace, this.unit, this.metric_name, this.dimensions});

  factory Metric.fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);
  Map<String, dynamic> toJson() => _$MetricToJson(this);

}

@JsonSerializable()
class Dimension {
  String name;
  String value;

  Dimension({this.name, this.value});

  factory Dimension.fromJson(Map<String, dynamic> json) => _$DimensionFromJson(json);
  Map<String, dynamic> toJson() => _$DimensionToJson(this);

}

@JsonSerializable()
class Metadata {
  int count;
  int total;
  String marker;

  Metadata({this.count, this.total, this.marker});

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);
  Map<String, dynamic> toJson() => _$MetadataToJson(this);

}

@JsonSerializable()
class MetricDataResponse {

  List<Datapoint> datapoints;
  String metric_name;

  MetricDataResponse({this.metric_name, this.datapoints});

  factory MetricDataResponse.fromJson(Map<String, dynamic> json) => _$MetricDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MetricDataResponseToJson(this);

}

@JsonSerializable()
class Datapoint {
  int average;
  int max;
  int min;
  int sum;
  int variance;
  int timestamp;
  String unit;

  int getData() {
    return average != null ? average : max != null ? max : min != null ? min : sum != null ? sum : variance != null ? variance : 0;
  }

  Datapoint({this.timestamp, this.unit});

  factory Datapoint.fromJson(Map<String, dynamic> json) => _$DatapointFromJson(json);
  Map<String, dynamic> toJson() => _$DatapointToJson(this);

}