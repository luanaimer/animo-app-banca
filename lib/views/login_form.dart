import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/provider/humor_repository.dart';
import 'package:flutter_application_1/views/reset_password.dart';
import 'package:flutter_application_1/views/signup_form.dart';
import 'package:provider/src/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 64, bottom: 46),
                child: Image.asset('assets/images/animo-logo-52px.png'),
              ),
              // Text('Bem vindo',
              //     style: TextStyle(
              //         fontSize: 35,
              //         fontWeight: FontWeight.bold,
              //         letterSpacing: -1.5)),
              Padding(
                padding:
                    EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 12),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null) {
                      return 'Informe um email válido!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                child: TextFormField(
                  controller: senha,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null) {
                      return 'Informe sua senha!';
                    } else if (value.length < 6) {
                      return 'Sua senha deve ter no mínimo 6 caracteres!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPasswordForm()),
                        );
                      },
                      child: Text('Esqueceu sua senha?'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await context
                          .read<AuthServices>()
                          .login(email.text, senha.text);

                      //await context.read<HumoresRepository>().readHumores();
                    } on AuthException catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Entrar',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(24),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpForm()),
                      );
                    },
                    child: Text('Ainda não tem conta? Cadastre-se'),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
