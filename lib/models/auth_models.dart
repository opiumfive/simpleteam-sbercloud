import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../const.dart';
part 'auth_models.g.dart';

@JsonSerializable()
class User {
  String id;
  String name;

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, name: $name}';
  }
}

@JsonSerializable()
class LoginResponse {
  // ignore: non_constant_identifier_names
  Token token;

  // ignore: non_constant_identifier_names
  LoginResponse({this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @override
  String toString() {
    return 'LoginResponse{token: $token}';
  }
}

@JsonSerializable()
class Token {
  // ignore: non_constant_identifier_names
  String expires_at;
  //List<Catalog> catalog;
  User user;

  // ignore: non_constant_identifier_names
  Token({this.expires_at, this.user});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  String toString() {
    return 'Token{expires_at: $expires_at, user: $user}';
  }
}

@JsonSerializable()
class LoginRequest {
  Auth auth;

  LoginRequest({String login, String password}) {
    auth = Auth(login: login, password: password);
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  String toString() {
    return 'LoginRequest{auth: $auth}';
  }
}

@JsonSerializable()
class Auth {
  Identity identity;
  Scope scope = Scope();

  Auth({String login, String password}) {
    identity = Identity(login: login, pass: password);
  }

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
  Map<String, dynamic> toJson() => _$AuthToJson(this);

  @override
  String toString() {
    return 'Auth{identity: $identity, scope: $scope}';
  }
}

@JsonSerializable()
class Identity {
  List<String> methods = ["password"];
  Password password;

  Identity({String login, String pass}) {
    password = Password(login: login, pass: pass);
  }

  factory Identity.fromJson(Map<String, dynamic> json) => _$IdentityFromJson(json);
  Map<String, dynamic> toJson() => _$IdentityToJson(this);

  @override
  String toString() {
    return 'Identity{methods: $methods, password: $password}';
  }
}

@JsonSerializable()
class Password {
  UserCreds user;

  Password({String login, String pass}) {
    user = UserCreds(login, pass);
  }

  factory Password.fromJson(Map<String, dynamic> json) => _$PasswordFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordToJson(this);

  @override
  String toString() {
    return 'Password{user: $user}';
  }
}

@JsonSerializable()
class UserCreds {
  String name;
  String password;
  Domain domain = Domain();

  UserCreds(this.name, this.password);

  factory UserCreds.fromJson(Map<String, dynamic> json) => _$UserCredsFromJson(json);
  Map<String, dynamic> toJson() => _$UserCredsToJson(this);

  @override
  String toString() {
    return 'UserCreds{name: $name, password: $password, domain: $domain}';
  }
}

@JsonSerializable()
class Domain {
  String name = DOMAIN_NAME;

  Domain();

  factory Domain.fromJson(Map<String, dynamic> json) => _$DomainFromJson(json);
  Map<String, dynamic> toJson() => _$DomainToJson(this);

  @override
  String toString() {
    return 'Domain{name: $name}';
  }
}

@JsonSerializable()
class Scope {
  Project project = Project();

  Scope();

  factory Scope.fromJson(Map<String, dynamic> json) => _$ScopeFromJson(json);
  Map<String, dynamic> toJson() => _$ScopeToJson(this);

  @override
  String toString() {
    return 'Scope{project: $project}';
  }
}

@JsonSerializable()
class Project {
  String name = PROJECT_NAME;

  Project();

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  String toString() {
    return 'Project{name: $name}';
  }
}