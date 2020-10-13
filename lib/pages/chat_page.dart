import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final _msgController = TextEditingController();
  final _focusNode = FocusNode();

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
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) => Text('$i')),
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
            decoration: InputDecoration.collapsed(hintText: "Enviar mensaje"),
            onSubmitted: (_) {},
            onChanged: _handlerSubmit,
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.blue[400]),
              onPressed: () {},
            ),
          )
        ],
      ),
    ));
  }

  _handlerSubmit(String text) {
    print(text);
  }
}
