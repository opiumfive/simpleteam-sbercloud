import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../const.dart';
part 'cloud_eye_models.g.dart';

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