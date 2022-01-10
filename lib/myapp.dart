import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/humor_form.dart';
import 'package:flutter_application_1/views/humor_lista.dart';
import 'package:flutter_application_1/views/login_form.dart';
import 'package:flutter_application_1/views/signup_form.dart';
import 'package:flutter_application_1/widgets/auth_check.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cripto Moedas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: AuthCheck(),
      routes: {
        '/login_form': (_) => LoginForm(),
        '/signup_form': (_) => SignUpForm(),
        '/humor_lista': (_) => HumorLista(),
        '/humor_form': (_) => Humorform()
      },
    );
  }
}
