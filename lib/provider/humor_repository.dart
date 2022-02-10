import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/data/db_firestore.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/trofeu.dart';
import 'package:flutter_application_1/provider/trofeus_repository.dart';
import 'package:flutter_application_1/views/registros.dart';

class HumoresRepository with ChangeNotifier {
  List<Humor> _lista = [];

  late FirebaseFirestore db;
  late AuthServices auth;
  late TrofeusRepository trofeus;
  bool novaRecompensa = false;

  DateTime dataRegistro = new DateTime.now();

  HumoresRepository({required this.auth, required this.trofeus}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await readHumores();
    // _sortByDate();
  }

  // _sortByDate() {
  //   _lista.sort((a, b) => a.data.compareTo(b.data));
  // }

  _startFirestore() {
    db = DBFirestore.get();
  }

  readHumores() async {
    _lista.clear();
    //List<Offset> pointList = <Offset>[];
    if (auth.usuario != null && _lista.isEmpty) {
      //const timestamp = firebase.firestore.FieldValue.serverTimestamp;

      // db.collection('things').add({ ...myData, createdAt: timestamp() })

      // Query
      //db.collection('usuarios/${auth.usuario!.uid}/humores').orderBy('data').startAfter(today)

      // DateTime hoje = DateTime.now();

      DateTime _start = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, 0, 0);
      DateTime _end = DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);

      final snapshot = await db
          .collection('usuarios/${auth.usuario!.uid}/humores')
          .orderBy('data', descending: true)
          .where('data', isGreaterThanOrEqualTo: _start)
          .where('data', isLessThanOrEqualTo: _end)
          .get();

      snapshot.docs.forEach((doc) {
        Humor humor = Humor(
            id: doc.id,
            sentimento: doc.get('sentimento'),
            atividades: List.from(doc['atividades']),
            anotacao: doc.get('anotacao'),
            data: doc.get('data'),
            sentimentoNota: doc.get('sentimentoNota'));
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
    List atividadesLista = [];
    novaRecompensa = false;

    humor.atividades?.forEach((atividade) {
      atividadesLista.add(atividade);
    });

    await db
        .collection('usuarios/${auth.usuario!.uid}/humores')
        .doc(humor.id)
        .set({
      'id': humor.id,
      'sentimento': humor.sentimento,
      'sentimentoNota': humor.sentimentoNota,
      'atividades': FieldValue.arrayUnion(atividadesLista),
      'anotacao': humor.anotacao,
      'data': humor.data
    });

    await trofeus.read();
    Trofeu trofeu = trofeus.trofeuUser;

    int _descobridor = trofeu.descobridor;
    List<Timestamp> _aplicado = trofeu.aplicado;
    List<Timestamp> _determinado = trofeu.determinado;
    int _escritor = trofeu.escritor;
    int _engajado = trofeu.engajado;

    DateTime _ultimoDia;
    DateTime _ontem;
    DateTime _hoje = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);

    if (trofeu.descobridor < 1) {
      _descobridor = 1;
      novaRecompensa = true;
    }

    if (trofeu.aplicado.length < 7) {
      if (trofeu.aplicado.isNotEmpty) {
        _ultimoDia = trofeu.aplicado[trofeu.aplicado.length - 1].toDate();
        _ultimoDia =
            DateTime(_ultimoDia.year, _ultimoDia.month, _ultimoDia.day, 0, 0);

        _ontem = DateTime.now().subtract(Duration(days: 1));
        if ((_ultimoDia.year == _ontem.year) &&
            (_ultimoDia.month == _ontem.month) &&
            (_ultimoDia.day == _ontem.day)) {
          _aplicado.add(Timestamp.fromDate(_hoje));
        } else {
          _aplicado.clear();
        }
      } else {
        _aplicado.add(Timestamp.fromDate(_hoje));
      }

      if (_aplicado.length == 7) novaRecompensa = true;
    }

    if (trofeu.determinado.length < 30) {
      if (trofeu.determinado.isNotEmpty) {
        _ultimoDia = trofeu.determinado[trofeu.determinado.length - 1].toDate();
        _ultimoDia =
            DateTime(_ultimoDia.year, _ultimoDia.month, _ultimoDia.day, 0, 0);

        _ontem = DateTime.now().subtract(Duration(days: 1));
        if ((_ultimoDia.year == _ontem.year) &&
            (_ultimoDia.month == _ontem.month) &&
            (_ultimoDia.day == _ontem.day)) {
          _determinado.add(Timestamp.fromDate(_hoje));
        } else {
          _determinado.clear();
        }
      } else {
        _determinado.add(Timestamp.fromDate(_hoje));
      }

      if (_aplicado.length == 30) novaRecompensa = true;
    }

    if ((trofeu.escritor < 1) && (humor.anotacao != '')) {
      _escritor = 1;
      novaRecompensa = true;
    }

    if (trofeu.engajado < 1 && _aplicado.contains(Timestamp.fromDate(_hoje))) {
      _engajado = 1;
      novaRecompensa = true;
    }

    trofeus.save(Trofeu(
        descobridor: _descobridor,
        aplicado: _aplicado,
        determinado: _determinado,
        escritor: _escritor,
        engajado: _engajado));

    refreshHumores();
    notifyListeners();

    // _sortByDate();
  }

  remove(Humor humor) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/humores')
        .doc(humor.id)
        .delete();
    _lista.remove(humor);
    notifyListeners();

    // _sortByDate();
  }

  clearData() {
    _lista.clear();
    notifyListeners();
  }
}
