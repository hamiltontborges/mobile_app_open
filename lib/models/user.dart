import 'package:flutter/material.dart';

class Usuario {
  String? id;
  String? email;
  String? fullName;
  String? course;
  DateTime? birthDate;
  DateTime? lastLogin;
  DateTime? dateUpdate;
  DateTime? dateRegister;

  Usuario({
    @required this.id,
    this.email,
    this.fullName,
    this.course,
    this.birthDate,
    this.lastLogin,
    this.dateUpdate,
    this.dateRegister,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      course: json['course'],
      birthDate: json['birthDate'],
      lastLogin: json['lastLogin'],
      dateUpdate: json['dateUpdate'],
      dateRegister: json['dateRegister'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'course': course,
      'birthDate': birthDate,
      'lastLogin': lastLogin,
      'dateUpdate': dateUpdate,
      'dateRegister': dateRegister,
    };
  }


  // Future<void> addUser(id, email, fullname) {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   return users
  //       .doc(id)
  //       .set({
  //         'email': email,
  //         'full_name': fullname,
  //         'date_register': dateRegister,
  //         'birth_date': '',
  //         "course": '',
  //       })
  //       .then((value) => print("Usuário adicionado"))
  //       .catchError((error) => print("Erro ao adicionar usuário: $error"));
  // }

  // Future<void> updateLoginUser(id, lastLogin) {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   return users
  //       .doc(id)
  //       .update({
  //         'last_login': lastLogin,
  //       })
  //       .then((value) => print("Data de login atualizada"))
  //       .catchError(
  //           (error) => print("Erro ao atualizar data de login: $error"));
  // }

  // Future<void> updateUser(id, fullName, birthDate, dateUpdate, course) {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   return users
  //       .doc(id)
  //       .update({
  //         'full_name': fullName,
  //         'birth_date': birthDate,
  //         'date_update': dateUpdate,
  //         'course': course,
  //       })
  //       .then((value) => print("Usuário atualizado"))
  //       .catchError((error) => print("Erro ao atualizar usuário: $error"));
  // }

  // Future<void> getUser(id) {
  //   CollectionReference users = FirebaseFirestore.instance.collection('users');
  //   return users.doc(id).get().then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       Map<String, dynamic> dados =
  //           documentSnapshot.data() as Map<String, dynamic>;
  //       print(dados);
  //     }
  //   });
  // }
}
