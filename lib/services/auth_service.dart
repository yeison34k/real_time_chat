import 'dart:convert';

import 'package:flutter/material.dart';
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

  Future<bool> login(String user, String password) async  {
    this.authenticate = true;
    final data = {
      'email': user,
      'password': password,
    };

    final response = await http.post('${Environment.api}/login', body: jsonEncode(data));
    this.authenticate = false;
    if (response.statusCode == 200) {
      final res = loginResponseFromJson(response.body);
      this.user = res.userDb;
      return true;
    } else {
      return true;
    }
  }
}