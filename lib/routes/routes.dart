import 'package:real_time_chat/pages/chat_page.dart';
import 'package:real_time_chat/pages/loading_page.dart';
import 'package:real_time_chat/pages/register_page.dart';
import 'package:real_time_chat/pages/usuarios_page.dart';

final Map<String, dynamic> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'login': (_) => LoadingPage(),
  'register': (_) => RegisterPage(),
  'chat': (_) => ChatPage(),
  'loading': (_) => LoadingPage(),
};
