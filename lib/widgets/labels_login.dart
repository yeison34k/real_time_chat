import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String route;
  final String label;
  final String text;

  const Labels({Key key, this.route, this.label, this.text}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Text(this.label,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.w300)),
            SizedBox(height: 10),
            GestureDetector(
              child: Text(text,
                  style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, this.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}