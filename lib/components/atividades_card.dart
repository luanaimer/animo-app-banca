import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/palette.dart';
import 'package:flutter_application_1/provider/atividade_repository.dart';
import 'package:provider/provider.dart';

class AtividadeCard extends StatefulWidget {
  final List<String> listaAtividadesSelecionadas;
  AtividadeCard(this.listaAtividadesSelecionadas);

  @override
  State<StatefulWidget> createState() => _AtividadeCard();
}

class _AtividadeCard extends State<AtividadeCard> {
  @override
  Widget build(BuildContext context) {
    CircleAvatar iconAtividade;
    Text textAtividade;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Consumer<AtividadesRepository>(
        builder: (context, atividades, child) {
          return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: atividades.lista.length,
              itemBuilder: (_, index) {
                //atividade_item
                textAtividade = Text(
                  atividades.lista[index].titulo,
                  textAlign: TextAlign.center,
                );
                return GestureDetector(
                  onTap: () {
                    if (widget.listaAtividadesSelecionadas
                        .contains(atividades.lista[index].titulo)) {
                      widget.listaAtividadesSelecionadas
                          .remove(atividades.lista[index].titulo);
                    } else {
                      widget.listaAtividadesSelecionadas
                          .add(atividades.lista[index].titulo);
                    }
                    //print(atividades.lista[index].titulo);
                    setState(() {});
                  },
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: widget.listaAtividadesSelecionadas
                                .contains(atividades.lista[index].titulo)
                            ? Palette.kPrimaryColor.shade500
                            : Colors.grey.shade500,
                        child: Icon(
                          atividades.lista[index].iconData,
                          color: Colors.white,
                        ),
                      ),
                      textAtividade
                    ],
                  ),
                );
              },
              gridDelegate:
                  //SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 10)
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                //childAspectRatio: 5
                //mainAxisSpacing: 10,
              ));
        },
      ),
    );
  }
}
