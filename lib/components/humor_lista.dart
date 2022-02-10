import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/AppIcons.dart';
import 'package:flutter_application_1/data/constants.dart';

class HumorLista extends StatefulWidget {
  final ValueChanged<String> selectedItem;
  String loadSelectedItem;

  HumorLista(
      {Key? key, required this.selectedItem, required this.loadSelectedItem})
      : super(key: key);

  @override
  _HumorLista createState() => _HumorLista();
}

class _HumorLista extends State<HumorLista> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (widget.loadSelectedItem != cMuitoMal) {
                widget.loadSelectedItem = cMuitoMal;
                widget.selectedItem(cMuitoMal);
              } else {
                widget.loadSelectedItem = cNenhum;
                widget.selectedItem(cNenhum);
              }

              setState(() {});
            },
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(widget.loadSelectedItem == cMuitoMal
                    ? 'assets/images/009-dizzy.png'
                    : 'assets/images/009-dizzy-disabled.png')),
          ),
          GestureDetector(
            onTap: () {
              if (widget.loadSelectedItem != cMal) {
                widget.loadSelectedItem = cMal;
                widget.selectedItem(cMal);
              } else {
                widget.loadSelectedItem = cNenhum;
                widget.selectedItem(cNenhum);
              }
              setState(() {});
            },
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(widget.loadSelectedItem == cMal
                    ? 'assets/images/010-frown.png'
                    : 'assets/images/010-frown-disabled.png')),
          ),
          GestureDetector(
            onTap: () {
              if (widget.loadSelectedItem != cNeutro) {
                widget.loadSelectedItem = cNeutro;
                widget.selectedItem(cNeutro);
              } else {
                widget.loadSelectedItem = cNenhum;
                widget.selectedItem(cNenhum);
              }
              setState(() {});
            },
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(widget.loadSelectedItem == cNeutro
                    ? 'assets/images/006-meh.png'
                    : 'assets/images/006-meh-disabled.png')),
          ),
          GestureDetector(
            onTap: () {
              if (widget.loadSelectedItem != cFeliz) {
                widget.loadSelectedItem = cFeliz;
                widget.selectedItem(cFeliz);
              } else {
                widget.loadSelectedItem = cNenhum;
                widget.selectedItem(cNenhum);
              }
              setState(() {});
            },
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(widget.loadSelectedItem == cFeliz
                    ? 'assets/images/008-smiling-face.png'
                    : 'assets/images/008-smiling-face-disabled.png')),
          ),
          GestureDetector(
            onTap: () {
              if (widget.loadSelectedItem != cRadiante) {
                widget.loadSelectedItem = cRadiante;
                widget.selectedItem(cRadiante);
              } else {
                widget.loadSelectedItem = cNenhum;
                widget.selectedItem(cNenhum);
              }
              setState(() {});
            },
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(widget.loadSelectedItem == cRadiante
                    ? 'assets/images/007-laugh.png'
                    : 'assets/images/007-laugh-disabled.png')),
          ),
        ],
      ),
    );
  }
}
