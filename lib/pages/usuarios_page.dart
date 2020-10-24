import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:real_time_chat/models/user.dart';

import 'package:real_time_chat/services/user_service.dart';
import 'package:real_time_chat/services/auth_service.dart';
import 'package:real_time_chat/services/socket_service.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final UserService userService = new UserService();
  List<User> users = [];

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _cargarUser();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final user = authService.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.nombre.toString()),
        elevation: 1,
        leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
              socketService.disconnect();
            }),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _cargarUser,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue,
          ),
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
    this.users = await userService.getAllUser();
    setState(() {
      
    });
    
    _refreshController.refreshCompleted();
  }
}
