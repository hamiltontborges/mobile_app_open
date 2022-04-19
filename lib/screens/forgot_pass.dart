import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/utils/snackbar.dart';
import 'package:provider/provider.dart';

import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:mobile_app_open/utils/logo.dart';
import 'package:mobile_app_open/utils/form_variables.dart';
import 'package:mobile_app_open/utils/validators.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }

  resetPass() async {
    try {
      await context.read<AuthService>().resetPassword(email.text);
      snackBar(context, "Email de recuperação de senha enviado.",
          color: Colors.green);
      Navigator.of(context).pop();
    } on AuthException catch (e) {
      snackBar(context, e.message, color: Colors.red);

    }
  }

  Widget _buildEmailForm() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      style: kTextStyleWhite,
      cursorColor: kColorWhite,
      decoration:
          inputDecorationWhite(Icons.email, "Email", "Digite seu email"),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe o email';
        } else if (!validateEmail(value)) {
          return 'Email inválido';
        }
        return null;
      },
    );
  }

  Widget _buildResetBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            resetPass();
          }
        },
        icon: Icon(Icons.send_outlined, color: kColorBlue),
        label: Text("Recuperar senha", style: kStyleTextButton),
        style: kStyleButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorDarkBlue,
        title: Text('Recuperar senha'),
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(
                Icons.login,
                color: kColorYellow,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              label: Text(
                'Entrar',
                style: TextStyle(color: kColorYellow, fontSize: 16),
              )),
        ],
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kColorBlue,
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    logoOpen(100.0),
                    SizedBox(height: 20.0),
                    Form(
                      key: formKey,
                      child: Column(children: [
                        SizedBox(height: 30.0),
                        _buildEmailForm(),
                        _buildResetBtn(),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
