import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat/pages/login_page.dart';
import 'package:real_time_chat/pages/usuarios_page.dart';

import 'package:real_time_chat/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Cargando...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context);
    final authenticate = await authService.isLoggedIn();
    if (authenticate) {
      Navigator.pushReplacement(context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => UsuariosPage(), transitionDuration: Duration(milliseconds: 0)));
    } else {
       Navigator.pushReplacement(context,
          PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage(), transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
