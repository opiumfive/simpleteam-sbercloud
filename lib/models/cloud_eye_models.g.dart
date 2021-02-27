// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_eye_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmRulesResponse _$AlarmRulesResponseFromJson(Map<String, dynamic> json) {
  return AlarmRulesResponse(
    meta_data: json['meta_data'] == null
        ? null
        : Metadata.fromJson(json['meta_data'] as Map<String, dynamic>),
    metric_alarms: (json['metric_alarms'] as List)
        ?.map((e) =>
            e == null ? null : MetricAlarm.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AlarmRulesResponseToJson(AlarmRulesResponse instance) =>
    <String, dynamic>{
      'metric_alarms': instance.metric_alarms,
      'meta_data': instance.meta_data,
    };

MetricAlarm _$MetricAlarmFromJson(Map<String, dynamic> json) {
  return MetricAlarm()
    ..alarm_name = json['alarm_name'] as String
    ..alarm_description = json['alarm_description'] as String
    ..metric = json['metric'] == null
        ? null
        : Metric.fromJson(json['metric'] as Map<String, dynamic>)
    ..alarm_enabled = json['alarm_enabled'] as bool
    ..alarm_level = json['alarm_level'] as int
    ..alarm_action_enabled = json['alarm_action_enabled'] as bool
    ..alarm_id = json['alarm_id'] as String
    ..update_time = json['update_time'] as int
    ..alarm_state = json['alarm_state'] as String
    ..condition = json['condition'] == null
        ? null
        : Condition.fromJson(json['condition'] as Map<String, dynamic>);
}

Map<String, dynamic> _$MetricAlarmToJson(MetricAlarm instance) =>
    <String, dynamic>{
      'alarm_name': instance.alarm_name,
      'alarm_description': instance.alarm_description,
      'metric': instance.metric,
      'alarm_enabled': instance.alarm_enabled,
      'alarm_level': instance.alarm_level,
      'alarm_action_enabled': instance.alarm_action_enabled,
      'alarm_id': instance.alarm_id,
      'update_time': instance.update_time,
      'alarm_state': instance.alarm_state,
      'condition': instance.condition,
    };

Condition _$ConditionFromJson(Map<String, dynamic> json) {
  return Condition()
    ..period = json['period'] as int
    ..filter = json['filter'] as String
    ..comparison_operator = json['comparison_operator'] as String
    ..value = json['value'] as int
    ..unit = json['unit'] as String
    ..count = json['count'] as int;
}

Map<String, dynamic> _$ConditionToJson(Condition instance) => <String, dynamic>{
      'period': instance.period,
      'filter': instance.filter,
      'comparison_operator': instance.comparison_operator,
      'value': instance.value,
      'unit': instance.unit,
      'count': instance.count,
    };

QuotasResponse _$QuotasResponseFromJson(Map<String, dynamic> json) {
  return QuotasResponse(
    quotas: json['quotas'] == null
        ? null
        : Quotas.fromJson(json['quotas'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QuotasResponseToJson(QuotasResponse instance) =>
    <String, dynamic>{
      'quotas': instance.quotas,
    };

Quotas _$QuotasFromJson(Map<String, dynamic> json) {
  return Quotas(
    resources: (json['resources'] as List)
        ?.map((e) =>
            e == null ? null : Resource.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuotasToJson(Quotas instance) => <String, dynamic>{
      'resources': instance.resources,
    };

Resource _$ResourceFromJson(Map<String, dynamic> json) {
  return Resource(
    type: json['type'] as String,
    unit: json['unit'] as String,
    used: json['used'] as int,
    quota: json['quota'] as int,
  );
}

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
      'type': instance.type,
      'unit': instance.unit,
      'used': instance.used,
      'quota': instance.quota,
    };

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
