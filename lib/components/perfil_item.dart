import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/alteraremail.dart';
import 'package:flutter_application_1/views/alterarnome.dart';
import 'package:flutter_application_1/views/alterarsenha.dart';

class PerfilItem extends StatefulWidget {
  final int index;

  const PerfilItem(this.index);

  @override
  _PerfilItemState createState() => _PerfilItemState();
}

bool isLoading = false;

class _PerfilItemState extends State<PerfilItem> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;

    List _listaAcoes = [
      ListTile(
        title: Text('Nome'),
        leading: Icon(Icons.person),
        trailing: IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlterarNomeForm()),
            );
          },
        ),
      ),
      ListTile(
        title: Text('Email'),
        leading: Icon(Icons.email),
        trailing: IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlteraremailForm()),
            );
          },
        ),
      ),
      ListTile(
        title: Text('Senha'),
        leading: Icon(Icons.lock),
        trailing: IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AlterarsenhaForm()),
            );
          },
        ),
      ),
    ];

    return _listaAcoes[widget.index];
  }
}
