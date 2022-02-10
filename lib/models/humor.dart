import 'package:cloud_firestore/cloud_firestore.dart';
import 'atividade.dart';

class Humor {
  final String? id;
  final String sentimento;
  final int sentimentoNota;
  final List<String>? atividades; //precisa virar lista
  final String? anotacao;
  final Timestamp data;

  const Humor(
      {this.id,
      required this.sentimento,
      required this.sentimentoNota,
      this.atividades,
      this.anotacao,
      required this.data});
}
