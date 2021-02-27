// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

UserDetailResponse _$UserDetailResponseFromJson(Map<String, dynamic> json) {
  return UserDetailResponse(
    user: json['user'] == null
        ? null
        : UserDetail.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserDetailResponseToJson(UserDetailResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

UserDetail _$UserDetailFromJson(Map<String, dynamic> json) {
  return UserDetail(
    id: json['id'] as String,
    name: json['name'] as String,
    domain_id: json['domain_id'] as String,
    img_path: json['img_path'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$UserDetailToJson(UserDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'domain_id': instance.domain_id,
      'img_path': instance.img_path,
      'email': instance.email,
      'phone': instance.phone,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    users: (json['users'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

UserProject _$UserProjectFromJson(Map<String, dynamic> json) {
  return UserProject(
    id: json['id'] as String,
    name: json['name'] as String,
    domain: json['domain'] == null
        ? null
        : Domain.fromJson(json['domain'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserProjectToJson(UserProject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'domain': instance.domain,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    token: json['token'] == null
        ? null
        : Token.fromJson(json['token'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    expires_at: json['expires_at'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    project: json['project'] == null
        ? null
        : UserProject.fromJson(json['project'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'expires_at': instance.expires_at,
      'user': instance.user,
      'project': instance.project,
    };

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return LoginRequest()
    ..auth = json['auth'] == null
        ? null
        : Auth.fromJson(json['auth'] as Map<String, dynamic>);
}

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'auth': instance.auth,
    };

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth()
    ..identity = json['identity'] == null
        ? null
        : Identity.fromJson(json['identity'] as Map<String, dynamic>)
    ..scope = json['scope'] == null
        ? null
        : Scope.fromJson(json['scope'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'identity': instance.identity,
      'scope': instance.scope,
    };

Identity _$IdentityFromJson(Map<String, dynamic> json) {
  return Identity()
    ..methods = (json['methods'] as List)?.map((e) => e as String)?.toList()
    ..password = json['password'] == null
        ? null
        : Password.fromJson(json['password'] as Map<String, dynamic>);
}

Map<String, dynamic> _$IdentityToJson(Identity instance) => <String, dynamic>{
      'methods': instance.methods,
      'password': instance.password,
    };

Password _$PasswordFromJson(Map<String, dynamic> json) {
  return Password()
    ..user = json['user'] == null
        ? null
        : UserCreds.fromJson(json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PasswordToJson(Password instance) => <String, dynamic>{
      'user': instance.user,
    };

UserCreds _$UserCredsFromJson(Map<String, dynamic> json) {
  return UserCreds(
    json['name'] as String,
    json['password'] as String,
  )..domain = json['domain'] == null
      ? null
      : Domain.fromJson(json['domain'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UserCredsToJson(UserCreds instance) => <String, dynamic>{
      'name': instance.name,
      'password': instance.password,
      'domain': instance.domain,
    };

Domain _$DomainFromJson(Map<String, dynamic> json) {
  return Domain()
    ..name = json['name'] as String
    ..id = json['id'] as String;
}

Map<String, dynamic> _$DomainToJson(Domain instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  return val;
}

Scope _$ScopeFromJson(Map<String, dynamic> json) {
  return Scope()
    ..project = json['project'] == null
        ? null
        : Project.fromJson(json['project'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ScopeToJson(Scope instance) => <String, dynamic>{
      'project': instance.project,
    };

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project()..name = json['name'] as String;
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'name': instance.name,
    };
