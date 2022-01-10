import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:flutter_application_1/provider/humor_repository.dart';
import 'package:provider/provider.dart';

class Humorform extends StatefulWidget {
  @override
  _HumorFormState createState() => _HumorFormState();
}

class _HumorFormState extends State<Humorform> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  final Map<String, String> _formData = {};
  DateTime now = new DateTime.now();

  @override
  void _loadFormData(Humor humor) {
    if (humor != null) {
      _formData['id'] = humor.id ?? "";
      _formData['sentimento'] = humor.sentimento;
      _formData['atividade'] = humor.atividade ?? "";
    }
  }

  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final Humor humor = ModalRoute.of(context)!.settings.arguments as Humor;
      _loadFormData(humor);
    }

    late HumoresRepository humorRespository =
        Provider.of<HumoresRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de humor'),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                final isValid = _form.currentState!.validate();
                if (isValid) {
                  _form.currentState!.save();

                  setState(() {
                    _isLoading = true;
                  });

                  DateTime date = new DateTime(now.year, now.month, now.day,
                      now.hour, now.minute, now.second);

                  await humorRespository.save(
                    Humor(
                        id: _formData['id'],
                        sentimento: _formData['sentimento'] ?? "",
                        atividade: _formData['atividade'],
                        anotacao: _formData['anotacao'],
                        data: date.toString()),
                  );

                  setState(() {
                    _isLoading = false;
                  });

                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['sentimento'],
                      decoration: InputDecoration(labelText: 'Sentimento'),
                      onSaved: (value) => _formData['sentimento'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['atividade'],
                      decoration: InputDecoration(labelText: 'Atividade'),
                      onSaved: (value) => _formData['atividade'] = value!,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
