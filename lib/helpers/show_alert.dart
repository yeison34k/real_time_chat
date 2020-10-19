import 'package:flutter/material.dart';


showAler(BuildContext context, String title, String description) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        MaterialButton(
          child: Text("Ok"),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: () => Navigator.pop(context)
        )
      ],
    )
  );
}

