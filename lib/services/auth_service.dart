import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:real_time_chat/global/environment.dart';
import 'package:real_time_chat/models/login_response.dart';
import 'package:real_time_chat/models/user.dart';

class AuthService with ChangeNotifier {
  User user;
  bool _authenticate = false;

  bool get authenticate => this._authenticate;
  set authenticate(bool value) {
    this._authenticate = value;
    notifyListeners();
  }

  final _storage = new FlutterSecureStorage();

  static Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: "token");
  }

  static Future<void> deleteToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "token");
  }

  Future login(String user, String password) async {
    this.authenticate = true;
    final data = {
      'email': user,
      'password': password,
    };

    return buildDataUser("/login", data);
  }

  Future register(String name, String user, String password) async {
    this.authenticate = true;
    final data = {
      'nombre': name,
      'email': user,
      'password': password,
    };

    return buildDataUser("/login/new", data);
  }

  Future buildDataUser(path, data) async {
    final response = await http.post(Environment.apiLocal + path,
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});
    this.authenticate = false;
    if (response.statusCode == 200) {
      final res = loginResponseFromJson(response.body);
      this.user = res.user;
      await this.saveToken(res.token);
      return true;
    } else {
      return false;
    }
  }

  Future isLoggedIn() async {
    final token = await _storage.read(key: "token");
    final response = await http.get('${Environment.apiLocal}/login/newToken',
        headers: {"Content-Type": "application/json", "x-token": token});

    print(token);
    print(response.body);
    if (response.statusCode == 200) {
      final res = loginResponseFromJson(response.body);
      this.user = res.user;
      await this.saveToken(res.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future saveToken(String token) async {
    return await _storage.write(key: "token", value: token);
  }

  Future logout() async {
    await _storage.delete(key: "token");
  }
}
