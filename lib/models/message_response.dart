// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

import 'package:real_time_chat/models/message.dart';

MessageResponse messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());

class MessageResponse {
    MessageResponse({
        this.ok,
        this.messageResponseAs,
        this.messages,
    });

    bool ok;
    String messageResponseAs;
    List<Message> messages;

    factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
        ok: json["ok"],
        messageResponseAs: json["as"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "as": messageResponseAs,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    };
}