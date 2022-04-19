import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Users {
  final String? id;
  final String? email;
  final DateTime? birthDate;
  final String? fullName;
  final DateTime? lastLogin = DateTime.now();
  final DateTime? dateUpdate;
  final DateTime? dateRegister = DateTime.now();

  Users({
    this.email,
    this.id,
    this.fullName,
    this.birthDate,
    this.dateUpdate,
  });

  Future<void> addUser(id, email) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(id)
        .set({
          'email': email,
          'full_name': fullName,
          'date_register': dateRegister,
        })
        .then((value) => print("Usuário adicionado"))
        .catchError((error) => print("Erro ao adicionar usuário: $error"));
  }

  Future<void> updateLoginUser(id, lastLogin) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(id)
        .update({
          'last_login': lastLogin,
        })
        .then((value) => print("Data de login atualizada"))
        .catchError(
            (error) => print("Erro ao atualizar data de login: $error"));
  }

  Future<void> updateUser(id, fullName, birthDate, dateUpdate, course) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(id)
        .update({
          'full_name': fullName,
          'birth_date': birthDate,
          'date_update': dateUpdate,
          'course': course,
        })
        .then((value) => print("Usuário atualizado"))
        .catchError((error) => print("Erro ao atualizar usuário: $error"));
  }
}
