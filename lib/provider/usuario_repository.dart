import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/data/db_firestore.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioRepository with ChangeNotifier {
  late String nome;
  late String sobrenome;
  late Timestamp nascimento;
  late Timestamp horario;
  late bool notificacao = false;

  late FirebaseFirestore db;
  AuthServices auth;

  UsuarioRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await readUsuario();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  readUsuario() async {
    if (auth.usuario != null) {
      final snapshot = await db
          .collection('usuarios/${auth.usuario!.uid}/dadosUsuario')
          .get();

      for (var doc in snapshot.docs) {
        nascimento = doc.get('nascimento');
        nome = doc.get('nome');
        sobrenome = doc.get('sobrenome');

        notifyListeners();
      }
    }
  }

  registrar(
    String nome,
    String sobrenome,
    Timestamp nascimento,
  ) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/dadosUsuario')
        .doc(auth.usuario!.uid)
        .set({
      'nome': nome,
      'sobrenome': sobrenome,
      'nascimento': nascimento,
    });

    await db
        .collection('usuarios/${auth.usuario!.uid}/configuracao')
        .doc(auth.usuario!.uid)
        .set({
      'notificacao': false,
      'horario': Timestamp.fromDate(DateTime.now()),
    });

    readUsuario();
  }

  remove(Humor humor) async {}

  alterarNome(String nome, String sobrenome) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/dadosUsuario')
        .doc(auth.usuario!.uid)
        .set({
      'nome': nome,
      'sobrenome': sobrenome,
      'nascimento': nascimento,
    });

    readUsuario();
  }
}
