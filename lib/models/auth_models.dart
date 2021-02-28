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
class UserDetailResponse {
  UserDetail user;

  UserDetailResponse({this.user});

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) => _$UserDetailResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailResponseToJson(this);

}

@JsonSerializable()
class UserDetail {
  String id;
  String name;
  String domain_id;
  String img_path;
  String email;
  String phone;

  UserDetail({this.id, this.name, this.domain_id, this.img_path, this.email, this.phone});

  factory UserDetail.fromJson(Map<String, dynamic> json) => _$UserDetailFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailToJson(this);

  @override
  String toString() {
    return 'UserDetail{id: $id, name: $name, domain_id: $domain_id, img_path: $img_path, email: $email, phone: $phone}';
  }
}

@JsonSerializable()
class UserResponse {
  List<User> users;

  UserResponse({this.users});

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

}

@JsonSerializable()
class UserProject {
  String id;
  String name;
  Domain domain;

  UserProject({this.id, this.name, this.domain});

  factory UserProject.fromJson(Map<String, dynamic> json) => _$UserProjectFromJson(json);
  Map<String, dynamic> toJson() => _$UserProjectToJson(this);

  @override
  String toString() {
    return 'UserProject{id: $id, name: $name}';
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
  UserProject project;

  // ignore: non_constant_identifier_names
  Token({this.expires_at, this.user, this.project});

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

  LoginRequest({String login, String password, String project, String domain}) {
    auth = Auth(login: login, password: password, project: project, domain: domain);
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
  Scope scope;

  Auth({String login, String password, String project, String domain}) {
    identity = Identity(login: login, pass: password, domain: domain);
    scope = Scope(Project(project));
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

  Identity({String login, String pass, String domain}) {
    password = Password(UserCreds(login, pass, Domain(domain)));
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

  Password(this.user);

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
  Domain domain;

  UserCreds(this.name, this.password, this.domain);

  factory UserCreds.fromJson(Map<String, dynamic> json) => _$UserCredsFromJson(json);
  Map<String, dynamic> toJson() => _$UserCredsToJson(this);

  @override
  String toString() {
    return 'UserCreds{name: $name, password: $password, domain: $domain}';
  }
}

@JsonSerializable()
class Domain {
  String name;
  @JsonKey(includeIfNull: false)
  String id;

  Domain(this.name);

  factory Domain.fromJson(Map<String, dynamic> json) => _$DomainFromJson(json);
  Map<String, dynamic> toJson() => _$DomainToJson(this);

  @override
  String toString() {
    return 'Domain{name: $name}';
  }
}

@JsonSerializable()
class Scope {
  Project project;

  Scope(this.project);

  factory Scope.fromJson(Map<String, dynamic> json) => _$ScopeFromJson(json);
  Map<String, dynamic> toJson() => _$ScopeToJson(this);

  @override
  String toString() {
    return 'Scope{project: $project}';
  }
}

@JsonSerializable()
class Project {
  String name;

  Project(this.name);

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  String toString() {
    return 'Project{name: $name}';
  }
}