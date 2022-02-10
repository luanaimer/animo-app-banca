import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/data/db_firestore.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/trofeu.dart';

class TrofeusRepository with ChangeNotifier {
  late FirebaseFirestore db;
  late AuthServices auth;
  bool isLoading = false;
  late Trofeu trofeuUser;

  TrofeusRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  read() async {
    if (auth.usuario != null) {
      final snapshot =
          await db.collection('usuarios/${auth.usuario!.uid}/trofeus').get();

      snapshot.docs.forEach((doc) {
        Trofeu trofeu = Trofeu(
            determinado: List.from(doc['determinado']),
            aplicado: List.from(doc['aplicado']),
            descobridor: int.parse(doc['descobridor'].toString()),
            engajado: int.parse(doc['engajado'].toString()),
            escritor: int.parse(doc['escritor'].toString()));

        trofeuUser = trofeu;
        notifyListeners();
      });
    }
  }

  save(Trofeu trofeu) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/trofeus')
        .doc(auth.usuario!.uid)
        .set({
      'descobridor': trofeu.descobridor,
      'aplicado': trofeu.aplicado,
      'determinado': trofeu.determinado,
      'escritor': trofeu.escritor,
      'engajado': trofeu.engajado
    });

    notifyListeners();
  }

  clearData() {
    notifyListeners();
  }
}
