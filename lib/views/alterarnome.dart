import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/provider/usuario_repository.dart';
import 'package:provider/provider.dart';

class AlterarNomeForm extends StatefulWidget {
  const AlterarNomeForm({Key? key}) : super(key: key);

  @override
  _AlterarNomeFormState createState() => _AlterarNomeFormState();
}

class _AlterarNomeFormState extends State<AlterarNomeForm> {
  final nome = TextEditingController();
  final sobrenome = TextEditingController();
  late String nomeSt = '';
  late String sobrenomeSt = '';
  final _form = GlobalKey<FormState>();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    nomeSt = context.read<UsuarioRepository>().nome;
    sobrenomeSt = context.read<UsuarioRepository>().sobrenome;
  }

  @override
  Widget build(BuildContext context) {
    nome.text = nomeSt;
    sobrenome.text = sobrenomeSt;

    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  final isValid = _form.currentState!.validate();
                  if (isValid) {
                    context
                        .read<UsuarioRepository>()
                        .alterarNome(nome.text, sobrenome.text);

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Nome alterado com sucesso!')));
                  }
                },
                icon: Icon(Icons.done))
          ],
          centerTitle: true,
          title: Text(
            // DateFormat.yMMMMd().format(selectedDate),
            'Alterar nome',
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
                  controller: nome,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe seu nome!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: TextFormField(
                  controller: sobrenome,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: 'Sobrenome',
                  ),
                  // obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe seu sobrenome!';
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
