// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:real_time_chat/models/user.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.ok,
        this.msg,
        this.userDb,
        this.token,
    });

    bool ok;
    String msg;
    User userDb;
    String token;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        msg: json["msg"],
        userDb: User.fromJson(json["userDB"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "userDB": userDb.toJson(),
        "token": token,
    };
}