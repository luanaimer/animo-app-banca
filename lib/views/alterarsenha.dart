import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:provider/provider.dart';

class AlterarsenhaForm extends StatefulWidget {
  const AlterarsenhaForm({Key? key}) : super(key: key);

  @override
  _AlterarsenhaFormState createState() => _AlterarsenhaFormState();
}

class _AlterarsenhaFormState extends State<AlterarsenhaForm> {
  final oldsenha = TextEditingController();
  final senha = TextEditingController();
  final confirmarsenha = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  bool isValid = _form.currentState!.validate();

                  if (isValid) {
                    try {
                      await context
                          .read<AuthServices>()
                          .alterarSenha(senha.text, oldsenha.text);
                    } on AuthException catch (e) {
                      isValid = false;
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    }

                    if (isValid) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Senha alterada com sucesso!')));
                    }
                  }
                },
                icon: Icon(Icons.done))
          ],
          centerTitle: true,
          title: Text(
            // DateFormat.yMMMMd().format(selectedDate),
            'Alterar senha',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        body: Form(
          key: _form,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: TextFormField(
                  controller: oldsenha,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: 'Senha antiga',
                  ),
                  // obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe sua senha antiga!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: TextFormField(
                  controller: senha,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: 'Nova senha',
                  ),
                  // obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe sua nova senha!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: TextFormField(
                  controller: confirmarsenha,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: 'Confirmar nova senha',
                  ),
                  // obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirme sua nova senha';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
