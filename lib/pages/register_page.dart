import 'package:flutter/material.dart';
import 'package:real_time_chat/widgets/custom_buttom.dart';
import 'package:real_time_chat/widgets/custom_input.dart';
import 'package:real_time_chat/widgets/labels_login.dart';
import 'package:real_time_chat/widgets/logo_login.dart';

class RegisterPage extends StatelessWidget {
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
                  route: "login",
                  label: "¿Ya tienes cuenta?",
                  text: "Ingresa ahora!",
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
  final nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          CustomInput(
              icon: Icons.perm_identity,
              placeholder: "Nombre",
              textController: nombreController,
              keyBoardType: TextInputType.text),
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
            name: "Registrar",
            action: () {},
          )
        ],
      ),
    );
  }
}
