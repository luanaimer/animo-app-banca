import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthServices extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late FirebaseFirestore db;
  User? usuario;
  bool isLoading = true;
  bool isLogin = true;

  AuthServices() {
    _authCheck();
  }

  void _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Email já cadastrado!');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      await _getUser();
      //await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado!');
      } else if (e.code == 'wrong-password') {
        throw AuthException('A senha informada está incorreta!');
      } else {
        throw AuthException(
            'Aconteceu algum problema. Tente novamente em alguns instantes.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }

  resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw AuthException('Erro');
    }
  }

  alterarSenha(String newPassword, String currentPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    String email = '';
    email = user!.email!;
    final cred =
        EmailAuthProvider.credential(email: email, password: currentPassword);

    try {
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha informada é fraca!');
      } else if (e.code == 'wrong-password') {
        throw AuthException('A senha antiga está errada!');
      }
    }
  }

  alterarEmail(String emailAntigo, String newEmail, String password) async {
    var credential =
        EmailAuthProvider.credential(email: emailAntigo, password: password);

    try {
      await _auth.currentUser?.reauthenticateWithCredential(credential);
      await _auth.currentUser?.updateEmail(newEmail);
      login(newEmail, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw AuthException('O email informado é inválido!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Email já cadastrado!');
      } else if (e.code == 'requires-recent-login') {
        throw AuthException(
            'Seu email precisa ser verificado! Falha ao alterar email!');
      }
    }
  }

  //_auth.currentUser?.email.toString();
  //_auth.currentUser?.emailVerified();

}
