import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/atividades.dart';
import 'package:flutter_application_1/models/atividade.dart';

class AtividadeIcon {
  Atividade atividadeByName(String titulo) {
    IconData iconData = Icons.error;

    atividades_list.forEach((key, value) {
      if (value.titulo == titulo) {
        iconData = value.iconData;
      }
    });

    Atividade atividade = Atividade(titulo: titulo, iconData: iconData);

    return atividade;
  }
}
