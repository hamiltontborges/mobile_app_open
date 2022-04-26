import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_open/models/user.dart';
import 'package:mobile_app_open/providers/user_provider.dart';
import 'package:mobile_app_open/screens/home.dart';
import 'package:mobile_app_open/screens/login.dart';
import 'package:mobile_app_open/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    UsuarioProvider usuarioProvider = Provider.of<UsuarioProvider>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return Login();
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(auth.usuario?.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Usuário já existe');
          usuarioProvider.lastLoginUser(auth.usuario?.uid);
        } else {
          usuarioProvider.addUser(
            auth.usuario?.uid,
            auth.usuario?.email,
            auth.usuario?.displayName,
          );
        }
      });
      return Home();
    }
  }

  loading() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
