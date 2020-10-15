import 'package:flutter/material.dart';
import 'dart:async';

import 'package:real_time_chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _msgController = TextEditingController();
  final _focusNode = FocusNode();
  bool _escribiendo = false;
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          title: Column(children: <Widget>[
            CircleAvatar(
              child: Text("Ye", style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blueAccent,
              maxRadius: 12,
            ),
            SizedBox(height: 3),
            Text(
              "Yeison",
              style: TextStyle(color: Colors.black, fontSize: 12),
            )
          ])),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: _messages.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputArea(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputArea() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _msgController,
            focusNode: _focusNode,
            onSubmitted: _handlerSubmit,
            decoration: InputDecoration.collapsed(hintText: "Enviar mensaje"),
            onChanged: (text) {
              setState(() {
                if (text.trim().length > 0) {
                  _escribiendo = true;
                } else {
                  _escribiendo = false;
                }
              });
            },
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: IconTheme(
              data: IconThemeData(color: Colors.blue[400]),
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(Icons.send),
                onPressed: _escribiendo
                    ? () => _handlerSubmit(_msgController.text.trim())
                    : null,
              ),
            ),
          )
        ],
      ),
    ));
  }

  _handlerSubmit(String text) {

    if(text.length==0) return;

    _msgController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: text,
      uid: '123',
      animateControl: AnimationController(
          vsync: this, 
          duration: Duration(milliseconds: 400)
        ),
    );
    _messages.insert(0, newMessage);
    newMessage.animateControl.forward();
    setState(() {
      _escribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: Off socket

    for (ChatMessage message in _messages) {
      message.animateControl.dispose();
    }
    super.dispose();
  }
}
