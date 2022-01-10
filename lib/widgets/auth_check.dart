import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/auth_services.dart';
import 'package:flutter_application_1/views/humor_lista.dart';
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

    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return LoginForm();
    else
      return HumorLista();
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
