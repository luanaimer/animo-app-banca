import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class AlteraremailForm extends StatefulWidget {
  const AlteraremailForm({Key? key}) : super(key: key);

  @override
  _AlteraremailFormState createState() => _AlteraremailFormState();
}

class _AlteraremailFormState extends State<AlteraremailForm> {
  final email = TextEditingController();
  final senha = TextEditingController();
  final _formEmail = GlobalKey<FormState>();
  final _formSenha = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    email.text = context.read<AuthServices>().usuario!.email.toString();

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  final isValid = _formEmail.currentState!.validate();
                  if (isValid) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Digite sua senha'),
                          content: Form(
                            key: _formSenha,
                            child: SizedBox(
                              height: 80,
                              width: 500,
                              child: TextFormField(
                                controller: senha,
                                decoration: const InputDecoration(
                                  labelText: 'Senha',
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Informe sua senha';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Não')),
                            ElevatedButton(
                                onPressed: () async {
                                  final isValid =
                                      _formSenha.currentState!.validate();
                                  if (isValid) {
                                    try {
                                      await context
                                          .read<AuthServices>()
                                          .alterarEmail(
                                              context
                                                  .read<AuthServices>()
                                                  .usuario!
                                                  .email
                                                  .toString(),
                                              email.text,
                                              senha.text);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Email alterado com sucesso!')));
                                    } on AuthException catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(e.message)));
                                    }
                                  }
                                },
                                child: Text('Sim'))
                          ],
                        );
                      },
                    );
                  }
                  ;
                },
                icon: Icon(Icons.done))
          ],
          //backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            // DateFormat.yMMMMd().format(selectedDate),
            'Alterar email',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        body: Form(
          key: _formEmail,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  // obscureText: true,
                  validator: (value) {
                    if (value == null) {
                      return 'Informe um email válido';
                    } else if (value ==
                        context
                            .read<AuthServices>()
                            .usuario!
                            .email
                            .toString()) {
                      return 'Informe um novo email';
                    }
                    return null;
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 24, right: 24, top: 8, bottom: 8),
              //   child: TextFormField(
              //     controller: senha,
              //     decoration: InputDecoration(
              //       //border: OutlineInputBorder(),
              //       labelText: 'Informe sua senha',
              //     ),
              //     obscureText: true,
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'Informe sua senha';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
