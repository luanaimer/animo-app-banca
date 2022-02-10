import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/AppIcons.dart';
import 'package:flutter_application_1/data/constants.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:flutter_application_1/provider/humor_repository.dart';
import 'package:flutter_application_1/views/humor_form.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// class HumorItem extends StatelessWidget {
//   final Humor humor;

//   const HumorItem(this.humor);

class HumorItem extends StatefulWidget {
  final Humor humor;

  const HumorItem(this.humor);

  @override
  _HumorItemState createState() => _HumorItemState();
}

class _HumorItemState extends State<HumorItem> {
  late String _chosenValue;

  @override
  Widget build(BuildContext context) {
    final Image imagemHumor;

    switch (widget.humor.sentimento) {
      case cMuitoMal:
        imagemHumor = Image.asset('assets/images/009-dizzy.png');
        break;
      case cMal:
        imagemHumor = Image.asset('assets/images/010-frown.png');
        break;
      case cNeutro:
        imagemHumor = Image.asset('assets/images/006-meh.png');
        break;
      case cFeliz:
        imagemHumor = Image.asset('assets/images/008-smiling-face.png');
        break;
      case cRadiante:
        imagemHumor = Image.asset('assets/images/007-laugh.png');
        break;
      default:
        imagemHumor = Image.asset('assets/images/007-laugh.png');
    }

    //DateTime humorDate = DateTime.parse(humor.data);
    //String formatedHumorDate = DateFormat('dd/MM').format(humorDate);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: imagemHumor,
                title: Row(
                  children: [
                    Text(
                      widget.humor.sentimento,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Padding(padding: EdgeInsets.only(right: 12)),
                    Text(
                      DateFormat.Hm().format(DateTime.parse(
                          widget.humor.data.toDate().toString())),
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                subtitle: Text(widget.humor.atividades!.join(", ")),
                trailing: Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Text(
                      //   DateFormat.Hm()
                      //       .format(DateTime.parse(humor.data.toDate().toString())),
                      //   style: TextStyle(fontSize: 12),
                      // ),
                      // IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
                      DropdownButton<String>(
                        icon: Icon(Icons.more_horiz),
                        underline: SizedBox(),
                        items:
                            <String>['Editar', 'Excluir'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            if (newValue == 'Editar') {
                              // Navigator.of(context)
                              // .pushNamed('/humor_form', arguments: widget.humor);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Humorform(),
                                    settings:
                                        RouteSettings(arguments: widget.humor)),
                              );
                            } else if (newValue == 'Excluir') {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text('Excluir registro'),
                                        content: Text('Tem certeza?'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Não')),
                                          ElevatedButton(
                                              onPressed: () {
                                                Provider.of<HumoresRepository>(
                                                        context,
                                                        listen: false)
                                                    .remove(widget.humor);
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Sim'))
                                        ],
                                      ));
                            }
                          });
                        },
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     Navigator.of(context)
                      //         .pushNamed('/humor_form', arguments: humor);
                      //   },
                      //   icon: Icon(Icons.edit),
                      //   color: Colors.orange,
                      // ),
                      // IconButton(
                      //   onPressed: () {
                      //     showDialog(
                      //       context: context,
                      //       builder: (ctx) => AlertDialog(
                      //         title: Text('Excluir registro'),
                      //         content: Text('Tem certeza?'),
                      //         actions: <Widget>[
                      //           FlatButton(
                      //               onPressed: () {
                      //                 Navigator.of(context).pop();
                      //               },
                      //               child: Text('Não')),
                      //           FlatButton(
                      //               onPressed: () {
                      //                 Provider.of<HumoresRepository>(context,
                      //                         listen: false)
                      //                     .remove(humor);
                      //                 Navigator.of(context).pop();
                      //               },
                      //               child: Text('Sim'))
                      //         ],
                      //       ),
                      //     );
                      //   },
                      //   icon: Icon(Icons.delete),
                      //   color: Colors.red,
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
