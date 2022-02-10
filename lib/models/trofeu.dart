import 'package:cloud_firestore/cloud_firestore.dart';

class Trofeu {
  final int descobridor;
  final List<Timestamp> aplicado;
  final List<Timestamp> determinado;
  final int escritor;
  final int engajado;

  Trofeu(
      {required this.descobridor,
      required this.aplicado,
      required this.determinado,
      required this.escritor,
      required this.engajado});
}
