import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat/helpers/show_alert.dart';
import 'package:real_time_chat/widgets/custom_buttom.dart';
import 'package:real_time_chat/widgets/custom_input.dart';
import 'package:real_time_chat/widgets/labels_login.dart';
import 'package:real_time_chat/widgets/logo_login.dart';

import 'package:real_time_chat/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(),
                Form(),
                Labels(
                  route: "register",
                  label: "¿No tienes cuenta?",
                  text: "Crear una ahora!",
                ),
                Text("Terminos y condiciones!",
                    style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          CustomInput(
              icon: Icons.mail_outline,
              placeholder: "Email",
              textController: emailController,
              keyBoardType: TextInputType.emailAddress),
          CustomInput(
              icon: Icons.vpn_key,
              placeholder: "Password",
              textController: passwordController,
              isPassword: true,
              keyBoardType: TextInputType.visiblePassword),
          CustomButtom(
            name: "Ingresar",
            action: authService.authenticate ?  null : () async {
                FocusScope.of(context).unfocus();
                bool response = await authService.login(emailController.text.trim(), passwordController.text.trim());

                if(!response) {
                  showAler(context,"Login no valido!!", "Revisa los datos de ingreso");
                }

                
              },
          )
        ],
      ),
    );
  }
}
