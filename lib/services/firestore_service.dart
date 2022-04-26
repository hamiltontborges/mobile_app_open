import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_open/models/user.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get User
  Stream<List<Usuario>> getUsers() {
    return _db.collection('users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Usuario.fromJson(doc.data())).toList());
  }

  Future<void> setUser(String id, Usuario usuario) {
    var options = SetOptions(merge: true);
    return _db
        .collection('users')
        .doc(id)
        .set(usuario.toMap(), options)
        .then((value) => print("Usuário atualizado"))
        .catchError((error) => print("Erro ao atualizar usuário: $error"));
  }

    Future<void> updateLoginUser(String id, Usuario usuario) {
    return _db.collection('users')
        .doc(id)
        .update({
          'lastLogin': usuario.lastLogin,
        })
        .then((value) => print("Data de login atualizada"))
        .catchError(
            (error) => print("Erro ao atualizar data de login: $error"));
  }
}
