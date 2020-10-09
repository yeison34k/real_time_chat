import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final Function action;
  final String name;

  const CustomButtom({
    Key key, 
    @required this.action, 
    @required this.name
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: this.action,
      child: Container(
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(this.name,
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }
}
