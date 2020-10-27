import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat/services/auth_service.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animateControl;

  const ChatMessage({
    Key key, 
    @required this.text, 
    @required this.uid, 
    @required this.animateControl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    return FadeTransition(
      opacity: animateControl,
          child: SizeTransition(
            sizeFactor: CurvedAnimation(parent: animateControl, curve: Curves.easeOut),
                      child: Container(
        child: this.uid == authService.user.uid ? 
              _myMessage() : 
              _notMyMessage(),
      ),
          ),
    );
  }

  Widget _myMessage() {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(
              bottom: 5, 
              right: 5,
              left: 50
            ),
            child: Text(this.text, style: TextStyle(color: Colors.black87)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff4D9EF6))
            )
        );
  }

  Widget _notMyMessage() {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(
              bottom: 5, 
              right: 50,
              left: 5
            ),
            child: Text(this.text),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffE4E5E8))
            )
        );
  }
}
