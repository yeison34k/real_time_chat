import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi nombre"),
        elevation: 1,
        leading: IconButton(icon: Icon(Icons.exit_to_app), onPressed: null),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _cargarUser,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue,),
          waterDropColor: Colors.blue[400],
        ),
        child: _userListView(),
      ),
    );
  }

  ListView _userListView() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => userListTile(users[i]),
        separatorBuilder: (_, i) => Divider(),
        itemCount: users.length);
  }

  ListTile userListTile(User user) {
    return ListTile(
              title: Text(user.nombre),
              leading: CircleAvatar(
                child: Text(user.nombre.substring(0, 2)),
              ),
              trailing: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: user.online ? Colors.green[100] : Colors.red,
                    borderRadius: BorderRadius.circular(100)),
              ),
            );
  }

  void _cargarUser() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
