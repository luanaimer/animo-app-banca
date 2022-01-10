import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/data/auth_services.dart';
import 'package:flutter_application_1/data/db_firestore.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HumoresRepository with ChangeNotifier {
  List<Humor> _lista = [];

  late FirebaseFirestore db;
  late AuthServices auth;

  HumoresRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await readHumores();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  readHumores() async {
    if (auth.usuario != null && _lista.isEmpty) {
      final snapshot =
          await db.collection('usuarios/${auth.usuario!.uid}/humores').get();

      //await db.collection('usuarios/${auth.usuario!.uid}/humores').where();

      snapshot.docs.forEach((doc) {
        Humor humor = Humor(
            id: doc.id,
            sentimento: doc.get('sentimento'),
            atividade: doc.get('atividade'),
            anotacao: doc.get('anotacao'),
            data: doc.get('data'));
        _lista.add(humor);
        notifyListeners();
      });
    }
  }

  //isso precisa ser reimplementado para que não seja necessário ficar solicitando os dados do banco toda vez
  refreshHumores() async {
    _lista.clear();
    readHumores();
  }

  UnmodifiableListView<Humor> get lista => UnmodifiableListView(_lista);

  save(Humor humor) async {
    // if (humor.id == null) {
    //   _lista.add(humor);
    // }
    await db
        .collection('usuarios/${auth.usuario!.uid}/humores')
        .doc(humor.id)
        .set({
      'id': humor.id,
      'sentimento': humor.sentimento,
      'atividade': humor.atividade,
      'anotacao': humor.anotacao,
      'data': humor.data,
    });

    refreshHumores();
    notifyListeners();
  }

  remove(Humor humor) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/humores')
        .doc(humor.id)
        .delete();
    _lista.remove(humor);
    notifyListeners();
  }

  clearData() {
    _lista.clear();
    notifyListeners();
  }
}
