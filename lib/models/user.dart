import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? email;
  final String? id;

  Users({
    this.email,
    this.id,
  });

  Future<void> addUser(email, id) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final DateTime date_register = DateTime.now();

    return users
        .doc(id)
        .set({'email': email, 'date_register': date_register})
        .then((value) => print("Usuário adicionado"))
        .catchError((error) => print("Erro ao adicionar usuário: $error"));
  }

}






// import 'package:flutter/material.dart';

// // Import the firebase_core and cloud_firestore plugin
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddUser extends StatelessWidget {
//   final String email;

//   AddUser(
//     this.email,
//   );

//   @override
//   Widget build(BuildContext context) {
//     // Create a CollectionReference called users that references the firestore collection
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     Future<void> addUser() {
//       // Call the user's CollectionReference to add a new user
//       return users
//           .add({'email': email})
//           .then((value) => print("Usuário adicionado"))
//           .catchError((error) => print("Erro ao adicionar usuário: $error"));
//     }

//     return TextButton(
//       onPressed: addUser,
//       child: Text(
//         "Add User",
//       ),
//     );
//   }
// }

