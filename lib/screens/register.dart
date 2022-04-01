import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:mobile_app_open/utils/login_var.dart';
import 'package:mobile_app_open/utils/logo.dart';
import 'package:provider/provider.dart';

import '../utils/google_login_btn.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool? loading = false;

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  register() async {
    setState(() => loading == true);
    try {
      await context.read<AuthService>().registerUser(email.text, password.text);
      Navigator.pop(context);
    } on AuthException catch (e) {
      setState(() => loading == false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  validateEmail(email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  Widget _buildEmailForm() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      style: kTextStyleWhite,
      cursorColor: kColorWhite,
      decoration: inputDecoration(Icons.email, "Email", "Digite seu email"),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe o email corretamente';
        } else if (!validateEmail(value)) {
          return 'Email inválido';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordForm() {
    return TextFormField(
      controller: password,
      style: kTextStyleWhite,
      obscureText: true,
      cursorColor: kColorWhite,
      decoration: inputDecoration(Icons.lock, 'Senha', 'Digite sua senha'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe sua senha';
        } else if (value.length < 6) {
          return 'Sua senha deve ter no mínimo 6 dígitos';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordForm() {
    return TextFormField(
      controller: password,
      style: kTextStyleWhite,
      obscureText: true,
      cursorColor: kColorWhite,
      decoration: inputDecoration(
          Icons.lock, 'Confirmar senha', 'Digite novamente sua senha'),
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            register();
          }
        },
        icon: Icon(Icons.person_add,color: kColorBlue),
        label: Text("CADASTRAR", style: kStyleTextButton),
        style: kStyleButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorDarkBlue,
        title: Text('Cadastro'),
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
                    SizedBox(
                      height: 20.0,
                    ),
                    logoOpen(100.0),
                    Form(
                      key: formKey,
                      child: Column(children: [
                        SizedBox(height: 30.0),
                        _buildEmailForm(),
                        SizedBox(height: 20.0),
                        _buildPasswordForm(),
                        SizedBox(height: 20.0),
                        _buildConfirmPasswordForm(),
                        SizedBox(height: 10.0),
                        _buildRegisterBtn(),
                        alternativeEnterDivider(),
                        SizedBox(height: 20.0),
                        googleBtn(context),
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
