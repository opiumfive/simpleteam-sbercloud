import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
part 'models.g.dart';

@JsonSerializable()
class User {
  String uuid;
  String employee_uuid;
  String auth_login;
  String visible_name;
  bool active;

  User({this.uuid, this.employee_uuid, this.auth_login, this.visible_name, this.active});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{uuid: $uuid, employee_uuid: $employee_uuid, auth_login: $auth_login, visible_name: $visible_name, active: $active}';
  }
}

@JsonSerializable()
class LoginResponse {
  // ignore: non_constant_identifier_names
  String access_token;

  // ignore: non_constant_identifier_names
  LoginResponse({this.access_token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  String toString() {
    return 'LoginResponse{access_token: $access_token}';
  }
}

@JsonSerializable()
class LoginRequest {
  String login;
  String password;

  LoginRequest(this.login, this.password);

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  String toString() {
    return 'LoginRequest{login: $login, password: $password}';
  }
}