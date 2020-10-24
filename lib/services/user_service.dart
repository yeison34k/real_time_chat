import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:real_time_chat/global/environment.dart';
import 'package:real_time_chat/models/user_response.dart';
import 'package:real_time_chat/models/user.dart';
import 'package:real_time_chat/services/auth_service.dart';

class UserService {
  List<User> users;

  final _storage = new FlutterSecureStorage();

  Future<List<User>> getAllUser() async {
    final response = await http.get('${Environment.apiLocal}/user/getAllUsers',
        headers: {
          "Content-Type": "application/json",
          'x-token': await AuthService.getToken()
        });

    if (response.statusCode == 200) {
      final res = userResponseFromJson(response.body);
      return res.users;
    } else {
      return null;
    }
  }
}
