import 'package:flutter/material.dart';
import 'package:real_time_chat/models/user.dart';


class UsuariosPage extends StatefulWidget {

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final users = [
    User(uid: "1", nombre: "Juanito", email: "test@test.com", online: true),
    User(uid: "2", nombre: "Lucho", email: "test@test.com", online: false),
    User(uid: "3", nombre: "Maria", email: "test@test.com", online: true),  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi nombre"),
        elevation: 1,
        leading: IconButton(icon: Icon(Icons.exit_to_app), onPressed: null),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => ListTile(
          title: Text(users[i].nombre),
          leading: CircleAvatar(
            child: Text(users[i].nombre.substring(0, 2)),
          ),
          trailing: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: users[i].online ? Colors.green[100] :  Colors.red,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        ),
        separatorBuilder: (_, i) => Divider(), 
        itemCount: users.length
      ),
   );
  }
}