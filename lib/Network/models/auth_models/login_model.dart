import 'dart:convert';

/// code : "200"
/// msg : "Login Successfully"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsInBob25lIjoiMTIzNDU2Nzg5MCJ9.1691147851760150006e1a090bbc74456b80d933c7d54ac6fdab45e4c6e0bfec"
/// role : "Admin"

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    String? code,
    String? msg,
    String? token,
    String? role,
    String? userName,
  }) {
    _code = code;
    _msg = msg;
    _token = token;
    _role = role;
    _userName = userName;
  }

  LoginModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _token = json['token'] ?? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsInBob25lIjoiMTIzNDU2Nzg5MCJ9.1691147851760150006e1a090bbc74456b80d933c7d54ac6fdab45e4c6e0bfec";
    _role = json['role'];
    _userName = json['userName'];
  }
  String? _code;
  String? _msg;
  String? _token;
  String? _role;
  String? _userName;
  LoginModel copyWith({
    String? code,
    String? msg,
    String? token,
    String? role,
    String? userName,
  }) =>
      LoginModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        token: token ?? _token,
        role: role ?? _role,
        userName: userName ?? _userName,
      );
  String? get code => _code;
  String? get msg => _msg;
  String? get token => _token;
  String? get role => _role;
  String? get userName => _userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    map['token'] = _token;
    map['role'] = _role;
    map['userName'] = _userName;
    return map;
  }
}
