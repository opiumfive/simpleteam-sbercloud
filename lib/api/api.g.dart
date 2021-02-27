// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://some.some.ru';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<LoginResponse> login(loginRequest) async {
    ArgumentError.checkNotNull(loginRequest, 'loginRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/v3/auth/tokens',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LoginResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<void> projects(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    await _dio.request<void>('/v3/projects',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-Auth-Token': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  Future<MetricsResponse> eyeMetrics(token, project_id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(project_id, 'project_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/V1.0/$project_id/metrics',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-Auth-Token': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MetricsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<QuotasResponse> eyeQuotas(token, project_id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(project_id, 'project_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/V1.0/$project_id/quotas',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-Auth-Token': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = QuotasResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AlarmRulesResponse> eyeAlarmRules(token, project_id) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(project_id, 'project_id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/V1.0/$project_id/alarms',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-Auth-Token': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AlarmRulesResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<MetricDataResponse> eyeMetricData(token, project_id, queries) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(project_id, 'project_id');
    ArgumentError.checkNotNull(queries, 'queries');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/V1.0/$project_id/metric-data',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'X-Auth-Token': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MetricDataResponse.fromJson(_result.data);
    return value;
  }
}
