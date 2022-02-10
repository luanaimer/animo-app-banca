import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/models/trofeu.dart';
import 'package:flutter_application_1/provider/trofeus_repository.dart';
import 'package:flutter_application_1/provider/usuario_repository.dart';
import 'package:flutter_application_1/widgets/auth_check.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final sobrenome = TextEditingController();
  final email = TextEditingController();
  final confirmarEmail = TextEditingController();
  final senha = TextEditingController();
  final confirmarSenha = TextEditingController();
  final dataNascimento = TextEditingController();
  late Timestamp dataNascimentoTS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo cadastro'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  controller: nome,
                  decoration: InputDecoration(
                      // border: OutlineInputBorder(),
                      labelText: 'Nome',
                      hintText: 'Informe um nome válido'),
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: "* Informação obrigatória"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  controller: sobrenome,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Sobrenome',
                  ),
                  validator: (MultiValidator(
                    [
                      RequiredValidator(errorText: "* Informação obrigatória"),
                    ],
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  controller: dataNascimento,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: "Data de nascimento",
                  ),
                  onTap: () async {
                    DateTime date = DateTime(1900);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)))!;

                    dataNascimento.text = DateFormat("dd/MM/yyyy").format(date);
                    dataNascimentoTS = Timestamp.fromDate(date);
                  },
                  validator: (MultiValidator(
                    [
                      RequiredValidator(errorText: "* Informação obrigatória"),
                    ],
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (MultiValidator(
                    [
                      RequiredValidator(errorText: "* Informação obrigatória"),
                    ],
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  controller: confirmarEmail,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Confirmar email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (MultiValidator(
                    [
                      RequiredValidator(errorText: "* Informação obrigatória"),
                    ],
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: TextFormField(
                  controller: senha,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
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
                padding: EdgeInsets.only(bottom: 32),
                child: TextFormField(
                  controller: confirmarSenha,
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Confirmar senha',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.toString() != senha.text) {
                      return 'As senhas não conferem!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      try {
                        await context.read<AuthServices>().registrar(
                              email.text,
                              senha.text,
                            );

                        await context.read<UsuarioRepository>().registrar(
                            nome.text, sobrenome.text, dataNascimentoTS);

                        if (context.read<AuthServices>().usuario != null) {
                          await context.read<TrofeusRepository>().save(Trofeu(
                              aplicado: [],
                              descobridor: 0,
                              determinado: [],
                              engajado: 0,
                              escritor: 0));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AuthCheck()),
                          );
                        }
                      } on AuthException catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.message)));
                      }
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
