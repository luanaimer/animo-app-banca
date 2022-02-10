import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/data/atividades.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/data/db_firestore.dart';
import 'package:flutter_application_1/models/atividade.dart';
import 'package:flutter_application_1/models/atividade_humor.dart';
import 'package:flutter_application_1/models/atividade_estatistica.dart';
import 'package:flutter_application_1/models/estatistica.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EstatisticasRepository with ChangeNotifier {
  final List<Humor> _lista = [];
  final List<Estatistica> _listaEstatisticas = [];
  final List<AtividadeHumor> _listaAtividadesHumor = [];
  final List<AtividadeEstatistica> _listaMediaAtividade = [];
  final List<AtividadeEstatistica> _listaMediaAtividadeIndexada = [];

  late FirebaseFirestore db;
  late AuthServices auth;
  bool isLoading = false;

  DateTime dataRegistro = new DateTime.now();

  int atividadeIndex = 1;

  EstatisticasRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  readEstatisticas() async {
    _lista.clear();
    if (auth.usuario != null && _lista.isEmpty) {
      DateTime _start = DateTime(
          dataRegistro.subtract(Duration(days: 6)).year,
          dataRegistro.subtract(Duration(days: 6)).month,
          dataRegistro.subtract(Duration(days: 6)).day,
          0,
          0);
      DateTime _end = DateTime(
          dataRegistro.year, dataRegistro.month, dataRegistro.day, 23, 59, 59);

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

  calcEstatisticas() {
    num _mediaSentimento = 0;
    num _totalSentimentoNota = 0;
    num _qtdSentimento = 0;

    num _qtdAtividade = 0;

    DateTime _lastDay;
    DateTime _startDay;

    _listaAtividadesHumor.clear();

    if (_lista.length > 0) {
      _startDay = _lista[0].data.toDate();
      _lastDay = _startDay;
      for (var humor in _lista) {
        if ((humor.data.toDate().day == _startDay.day) |
            (humor.data.toDate().day == _lastDay.day)) {
          _qtdSentimento = _qtdSentimento + 1;
          _lastDay = DateTime(humor.data.toDate().year,
              humor.data.toDate().month, humor.data.toDate().day);
          _totalSentimentoNota = _totalSentimentoNota + humor.sentimentoNota;
        } else {
          _mediaSentimento = _totalSentimentoNota / _qtdSentimento;
          _listaEstatisticas.add(
              Estatistica(dia: _lastDay, mediaSentimento: (_mediaSentimento)));

          _qtdSentimento = 1;
          _totalSentimentoNota = humor.sentimentoNota;
          _lastDay = DateTime(humor.data.toDate().year,
              humor.data.toDate().month, humor.data.toDate().day);
        }

        humor.atividades?.forEach((atividade) {
          _listaAtividadesHumor
              .add(AtividadeHumor(atividade, humor.sentimentoNota));
        });
      }
      _mediaSentimento = _totalSentimentoNota / _qtdSentimento;
      _listaEstatisticas
          .add(Estatistica(dia: _lastDay, mediaSentimento: (_mediaSentimento)));
    }
  }

  num calcMediaAtividade(Atividade atividade) {
    num qtd = 0;
    num total = 0;
    num media = 0;

    for (var _mediaAtividade in _listaAtividadesHumor) {
      if (_mediaAtividade.atividade == atividade.titulo.toString()) {
        qtd = qtd + 1;
        total = total + _mediaAtividade.sentimentoNota;
      }
    }

    if (qtd > 0) {
      media = total / qtd;
    }

    return media;
  }

  readMediaAtividade() async {
    _listaMediaAtividade.clear();
    num media = 0;
    num progresso = 0;

    final List<Atividade> _listaTemp = [];
    atividades_list.forEach((key, atividade) {
      _listaTemp.add(atividade);
    });

    for (var atividade in _listaTemp) {
      media = calcMediaAtividade(atividade);
      if (media > 0) {
        progresso = media / 5;
        _listaMediaAtividade
            .add(AtividadeEstatistica(atividade, media, progresso));
      }
    }
  }

  returnMediaAtividade() async {
    _listaMediaAtividadeIndexada.clear();
    int index = (atividadeIndex * 4) - 4;

    for (var i = 0; i < 4; i++) {
      if (index <= (_listaMediaAtividade.length - 1)) {
        _listaMediaAtividadeIndexada.add(_listaMediaAtividade[index]);
      }
      index++;
    }
  }

  returnEstatisticas() async {
    _listaEstatisticas.clear();
    await readEstatisticas();
    await calcEstatisticas();
    await readMediaAtividade();
  }

  UnmodifiableListView<Estatistica> get lista =>
      UnmodifiableListView(_listaEstatisticas);

  UnmodifiableListView<AtividadeEstatistica> get listaMediaAtividade =>
      UnmodifiableListView(_listaMediaAtividade);

  UnmodifiableListView<AtividadeEstatistica> get listaMediaAtividadeIndexada =>
      UnmodifiableListView(_listaMediaAtividadeIndexada);
}
