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

  String getLevelName() {
    switch(alarm_level) {
      case 1:
        return "Critical";
      case 2:
        return "Major";
      case 3:
        return "Minor";
      case 4:
        return "Informational";
      default:
        return alarm_level.toString();
    }
  }
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

  String namespaceAndMetricName() {
    return namespace + "_" + metric_name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Metric &&
          runtimeType == other.runtimeType &&
          namespace == other.namespace &&
          metric_name == other.metric_name;

  @override
  int get hashCode => namespace.hashCode ^ metric_name.hashCode;

  String getHumanTitle() {
    return getHumanNamespace() + " " + getHumanName();
  }

  String  getHumanNamespace() {
    switch(namespace) {
      case "SYS.ECS":
        return "ECS";
      case "AGT.ECS":
        return "ECS";
      case "SYS.AS":
        return "AS";
      case "SYS.EVS":
        return "EVS";
      case "SYS.OBS":
        return "OBS";
      case "SYS.SFS":
        return "SFS";
      case "SYS.VPC":
        return "VPC";
      case "SYS.ELB":
        return "ELB";
      case "SYS.NAT":
        return "NAT";
      case "SYS.DMS":
        return "DMS";
      case "SYS.DCS":
        return "DCS";
      case "SYS.RDS":
        return "RDS";
      case "SYS.DDS":
        return "DDS";
      case "SYS.ES":
        return "ES";
      case "SYS.APIG":
        return "APIG";
      case "SYS.FunctionGraph":
        return "FunctionGraph";

      default:
        namespace;
    }
  }

  String getHumanName() {
    switch(metric_name) {
      case "cpu_util":
        return "CPU Usage";
      case "mem_util":
        return "Memory Usage";
      case "disk_util_inband":
        return "Disk Usage";
      case "disk_read_bytes_rate":
        return "Disk Read Bandwidth";
      case "disk_write_bytes_rate":
        return "Disk Write Bandwidth";
      case "disk_read_requests_rate":
        return "Disk Read IOPS";
      case "disk_write_requests_rate":
        return "Disk Write IOPS";
      case "network_incoming_bytes_rate_inband":
        return "Inband Incoming Rate";
      case "network_outgoing_bytes_rate_inband":
        return "Inband Outgoing Rate";
      case "network_incoming_bytes_aggregate_rate":
        return "Outband Incoming Rate";
      case "network_outgoing_bytes_aggregate_rate":
        return "Outband Outgoing Rate";
      case "instance_num":
        return "Inband Outgoing Rate";
      case "gpu_usage_mem":
        return "Video Memory Usage";
      case "gpu_usage_gpu":
        return "GPU Usage";
      case "mem_usedPercent":
        return "Memory Usage";
      case "mountPointPrefix_disk_free":
        return "Available Disk Space";
      case "mountPointPrefix_disk_usedPercent":
        return "Disk Usage";
      case "disk_ioUtils":
        return "Disk I/O Usage";
      case "disk_inodesUsedPercent":
        return "Percentage of Total inode Used";
      case "net_bitSent":
        return "Inbound Bandwidth";
      case "net_bitRecv":
        return "Outbound Bandwidth";
      case "net_packetRecv":
        return "NIC Packet Receive Rate";
      case "net_packetSent":
        return "NIC Packet Send Rate";
      case "net_tcp_total":
        return "Total number of TCP connections";
      case "net_tcp_established":
        return "Number of ESTABLISHED TCP connections";
      case "load_average15":
        return "15-Minute Load Average";
      case "load_average5":
        return "5-Minute Load Average";
      case "load_average1":
        return "1-Minute Load Average";
      case "disk_device_read_bytes_rate":
        return "Disk Read Bandwidth";
      case "disk_device_write_bytes_rate":
        return "Disk Write Bandwidth";
      case "disk_device_read_requests_rate":
        return "Disk Read IOPS";
      case "disk_device_write_requests_rate":
        return "Disk Write IOPS";
      case "download_bytes":
        return "Bytes Downloaded";
      case "upload_bytes":
        return "Bytes Uploaded";
      case "get_request_count":
        return "GET Requests";
      case "put_request_count":
        return "PUT Requests";
      case "first_byte_latency":
        return "First Byte Download Delay";
      case "request_count_4xx":
        return "4xx Errors";
      case "request_count_5xx":
        return "5xx Errors";
      case "read_bandwidth":
        return "Read Bandwidth";
      case "write_bandwidth":
        return "Write Bandwidth";
      case "rw_bandwidth":
        return "Read and Write Bandwidth";
      case "upstream_bandwidth":
        return "Outbound Bandwidth";
      case "downstream_bandwidth":
        return "Inbound Bandwidth";
      case "upstream_bandwidth_usage":
        return "Outbound Bandwidth Usage";
      case "up_stream":
        return "Outbound Traffic";
      case "down_stream":
        return "Inbound Traffic";
      case "rejectcount":
        return "Reject count";
      case "failcount":
        return "Fail count";
      case "minDuration":
        return "Min duration";
      case "maxDuration":
        return "Max duration";
      case "duration":
        return "Duration";
      case "count":
        return "Count";
      case "req_count_error":
        return "Requests error count";
      case "req_count_5xx":
        return "5xx requests";
      case "req_count_4xx":
        return "4xx requests";
      case "req_count_2xx":
        return "2xx requests";
      case "req_count":
        return "Requests";
      case "output_throughput":
        return "Output Throughput";
      case "input_throughput":
        return "Input Throughput";
      case "max_latency":
        return "Max latency";
      case "avg_latency":
        return "Average latency";
      default: return metric_name;
    }
  }

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
  double average;
  double max;
  double min;
  double sum;
  double variance;
  int timestamp;
  String unit;

  double getData() {
    return average != null ? average : max != null ? max : min != null ? min : sum != null ? sum : variance != null ? variance : 0;
  }

  Datapoint({this.timestamp, this.unit});

  factory Datapoint.fromJson(Map<String, dynamic> json) => _$DatapointFromJson(json);
  Map<String, dynamic> toJson() => _$DatapointToJson(this);

}