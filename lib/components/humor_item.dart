import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/constants.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:flutter_application_1/provider/humor_repository.dart';
import 'package:provider/provider.dart';

class HumorItem extends StatelessWidget {
  final Humor humor;

  const HumorItem(this.humor);

  @override
  Widget build(BuildContext context) {
    final CircleAvatar imagemHumor;

    switch (humor.sentimento) {
      case cHorrivel:
        imagemHumor = const CircleAvatar(child: Icon(Icons.person));
        break;
      case cMal:
        imagemHumor = const CircleAvatar(child: Icon(Icons.holiday_village));
        break;
      case cNeutro:
        imagemHumor = const CircleAvatar(child: Icon(Icons.access_alarm_sharp));
        break;
      case cFeliz:
        imagemHumor = const CircleAvatar(child: Icon(Icons.house));
        break;
      case cRadiante:
        imagemHumor =
            const CircleAvatar(child: Icon(Icons.accessibility_new_sharp));
        break;
      default:
        imagemHumor = const CircleAvatar(child: Icon(Icons.hourglass_empty));
    }

    return ListTile(
      leading: imagemHumor,
      title: Text(humor.sentimento),
      subtitle: Text(humor.atividade ?? ""),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/humor_form', arguments: humor);
              },
              icon: Icon(Icons.edit),
              color: Colors.orange,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir registro'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Não')),
                      FlatButton(
                          onPressed: () {
                            Provider.of<HumoresRepository>(context,
                                    listen: false)
                                .remove(humor);
                            Navigator.of(context).pop();
                          },
                          child: Text('Sim'))
                    ],
                  ),
                );
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
