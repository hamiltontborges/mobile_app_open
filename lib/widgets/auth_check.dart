import 'package:flutter/material.dart';
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

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return Login();
    } else {
      return Home();
    }
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator()
        ),
    );
  }
}
