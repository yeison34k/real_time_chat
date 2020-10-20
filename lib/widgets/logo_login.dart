import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/img/logo.png',
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
