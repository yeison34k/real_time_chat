import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:real_time_chat/widgets/chat_message.dart';
import 'package:real_time_chat/services/chat_service.dart';
import 'package:real_time_chat/services/socket_service.dart';
import 'package:real_time_chat/services/auth_service.dart';

import 'package:real_time_chat/models/message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _msgController = TextEditingController();
  final _focusNode = FocusNode();
  ChatService chatService;
  SocketService socketService;
  AuthService authService;
  bool _escribiendo = false;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    _loadChat(chatService.userTo.uid);
    this.socketService.socket.on("personal-message", _listenMessage);
  }

  _loadChat(String userId) async {
    List<Message> chat = await this.chatService.getChat(userId);
    final history = chat.map( (message) =>  new ChatMessage(
        text: message.message,
        uid: message.from,
        animateControl: AnimationController(
            vsync: this, duration: Duration(milliseconds: 400))..forward(),
      )
    );
    print(chat);
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic payload) {
    ChatMessage message = ChatMessage(
      text: payload['message'],
      uid: payload['from'],
      animateControl: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animateControl.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userTo = chatService.userTo;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          title: Column(children: <Widget>[
            CircleAvatar(
              child: Text(userTo.nombre.substring(0, 2),
                  style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blueAccent,
              maxRadius: 12,
            ),
            SizedBox(height: 3),
            Text(
              userTo.nombre,
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
    if (text.length == 0) return;

    _msgController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: text,
      uid: authService.user.uid,
      animateControl: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animateControl.forward();
    setState(() {
      _escribiendo = false;
    });

    this.socketService.emit('personal-message', {
      'from': authService.user.uid,
      'to': chatService.userTo.uid,
      'message': text
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animateControl.dispose();
    }
    this.socketService.socket.off("personal-message");
    super.dispose();
  }
}
