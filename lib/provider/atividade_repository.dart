import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/atividades.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/data/db_firestore.dart';
import 'package:flutter_application_1/models/atividade.dart';

class AtividadesRepository with ChangeNotifier {
  List<Atividade> _lista = [];
  late FirebaseFirestore db;
  late AuthServices auth;

  AtividadesRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() {
    _startFirestore();
    readAtividades();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  readAtividades() {
    atividades_list.forEach((key, value) {
      _lista.add(value);
    });
  }

  UnmodifiableListView<Atividade> get lista => UnmodifiableListView(_lista);
}
