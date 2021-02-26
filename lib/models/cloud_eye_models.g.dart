// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_eye_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetricsResponse _$MetricsResponseFromJson(Map<String, dynamic> json) {
  return MetricsResponse(
    metrics: (json['metrics'] as List)
        ?.map((e) =>
            e == null ? null : Metric.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    meta_data: json['meta_data'] == null
        ? null
        : Metadata.fromJson(json['meta_data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MetricsResponseToJson(MetricsResponse instance) =>
    <String, dynamic>{
      'metrics': instance.metrics,
      'meta_data': instance.meta_data,
    };

Metric _$MetricFromJson(Map<String, dynamic> json) {
  return Metric(
    namespace: json['namespace'] as String,
    unit: json['unit'] as String,
    metric_name: json['metric_name'] as String,
    dimensions: (json['dimensions'] as List)
        ?.map((e) =>
            e == null ? null : Dimension.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MetricToJson(Metric instance) => <String, dynamic>{
      'namespace': instance.namespace,
      'unit': instance.unit,
      'metric_name': instance.metric_name,
      'dimensions': instance.dimensions,
    };

Dimension _$DimensionFromJson(Map<String, dynamic> json) {
  return Dimension(
    name: json['name'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$DimensionToJson(Dimension instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) {
  return Metadata(
    count: json['count'] as int,
    total: json['total'] as int,
    marker: json['marker'] as String,
  );
}

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
      'marker': instance.marker,
    };

MetricDataResponse _$MetricDataResponseFromJson(Map<String, dynamic> json) {
  return MetricDataResponse(
    metric_name: json['metric_name'] as String,
    datapoints: (json['datapoints'] as List)
        ?.map((e) =>
            e == null ? null : Datapoint.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MetricDataResponseToJson(MetricDataResponse instance) =>
    <String, dynamic>{
      'datapoints': instance.datapoints,
      'metric_name': instance.metric_name,
    };

Datapoint _$DatapointFromJson(Map<String, dynamic> json) {
  return Datapoint(
    timestamp: json['timestamp'] as int,
    unit: json['unit'] as String,
  )
    ..average = json['average'] as int
    ..max = json['max'] as int
    ..min = json['min'] as int
    ..sum = json['sum'] as int
    ..variance = json['variance'] as int;
}

Map<String, dynamic> _$DatapointToJson(Datapoint instance) => <String, dynamic>{
      'average': instance.average,
      'max': instance.max,
      'min': instance.min,
      'sum': instance.sum,
      'variance': instance.variance,
      'timestamp': instance.timestamp,
      'unit': instance.unit,
    };
