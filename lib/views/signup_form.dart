import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/auth_services.dart';
import 'package:flutter_application_1/views/humor_lista.dart';
import 'package:flutter_application_1/views/login_form.dart';
import 'package:flutter_application_1/widgets/auth_check.dart';
import 'package:provider/src/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formkey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo cadastro'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('Cadastro novo',
              //     style: TextStyle(
              //         fontSize: 35,
              //         fontWeight: FontWeight.bold,
              //         letterSpacing: -1.5)),
              Padding(
                padding: EdgeInsets.all(12),
                child: TextFormField(
                  //controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  //keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null) {
                      return 'Informe o seu nome!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null) {
                      return 'Informe o seu email!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: TextFormField(
                  //controller: senha,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar senha',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != senha) {
                      return 'As senhas não conferem!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await context
                          .read<AuthServices>()
                          .registrar(email.text, senha.text);

                      if (context.read<AuthServices>().usuario != null) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/humor_lista', (route) => false);
                      }
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
                          'Cadastrar',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
