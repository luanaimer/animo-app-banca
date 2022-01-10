import 'package:cloud_firestore/cloud_firestore.dart';

class DBFirestore {
  DBFirestore._();
  static final DBFirestore _instance = DBFirestore._();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static FirebaseFirestore get() {
    return DBFirestore._instance._fireStore;
  }
}
