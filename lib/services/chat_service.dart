import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:real_time_chat/global/environment.dart';
import 'package:real_time_chat/models/message_response.dart';
import 'package:real_time_chat/models/user.dart';
import 'package:real_time_chat/services/auth_service.dart';

class ChatService with ChangeNotifier {
  User userTo;

  Future getChat(String fromTo) async {
    final response = await http.get("${Environment.apiLocal}/chat/getChat/" + fromTo, 
        headers: {
          "Content-Type": "application/json",
          'x-token': await AuthService.getToken()
    });

    if (response.statusCode == 200) {
      final res = messageResponseFromJson(response.body);
      return res.messages;
    } else {
      return [];
    }
  }
}
