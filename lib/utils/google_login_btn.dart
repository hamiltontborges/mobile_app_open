import 'package:flutter/material.dart';
import 'package:mobile_app_open/services/google_sign_in.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:mobile_app_open/utils/snackbar.dart';
import 'package:provider/provider.dart';

googleBtn(context) {
  return ElevatedButton.icon(
    icon: Image.asset('assets/logos/google.png', height: 30.0),
    style: ElevatedButton.styleFrom(
      primary: kColorWhite,
      onPrimary: kColorBlue,
      minimumSize: Size(double.infinity, 50),
    ),
    onPressed: () {
      final provider =
          Provider.of<GoogleSignInProvider>(context, listen: false);
      provider.googleLogin();
      snackBar(context, "Bem-vindo(a) ${provider.user.email}!", color: Colors.green);

    },
    label: Text(
      'Entrar com Google',
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
