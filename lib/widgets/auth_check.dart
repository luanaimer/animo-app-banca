import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/provider/usuario_repository.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/views/login_form.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthServices auth = Provider.of<AuthServices>(context);
    context.read<UsuarioRepository>().readUsuario();

    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return LoginForm();
    else
      return Home();
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
