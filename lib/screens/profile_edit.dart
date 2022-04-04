import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/utils/validators.dart';
import 'package:provider/provider.dart';

import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:mobile_app_open/utils/form_variables.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool? loading = false;

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();


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


  Widget _buildEmailForm() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      style: kTextStyleBlue,
      cursorColor: kColorBlue,
      decoration:
          inputDecorationBlue(Icons.email, "Email", "Digite seu email"),
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

  Widget _buildName() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      style: kTextStyleBlue,
      cursorColor: kColorBlue,
      decoration:
          inputDecorationBlue(Icons.email, "Nome", "Digite seu nome completo"),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe seu nome';
        } else if (value.length < 6) {
          return 'Seu nome deve ter no mínimo 8 dígitos';
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
      decoration: inputDecorationBlue(
          Icons.lock, 'Senha', 'Digite sua senha'),
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
      controller: confirmPassword,
      style: kTextStyleWhite,
      obscureText: true,
      cursorColor: kColorWhite,
      decoration: inputDecorationBlue(Icons.lock,
          'Confirmar senha', 'Digite novamente sua senha'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Preenchimento obrigatório';
        } else if (confirmPassword.text != password.text) {
          return 'As senhas não conferem';
        }
        return null;
      },
    );
  }

  Widget _buildAttBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            register();
          }
        },
        icon: Icon(Icons.arrow_upward, color: kColorBlue),
        label: Text("Atualizar", style: kStyleTextButton),
        style: kStyleButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorDarkBlue,
        title: Text('Meus dados'),
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
                color: kColorWhite,
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
          
                    Form(
                      key: formKey,
                      child: Column(children: [
                        SizedBox(height: 10.0),
                        _buildName(),
                        SizedBox(height: 20.0),
                        _buildEmailForm(),
                        SizedBox(height: 20.0),
                        _buildPasswordForm(),
                        SizedBox(height: 20.0),
                        _buildConfirmPasswordForm(),
                        SizedBox(height: 10.0),
                        _buildAttBtn(),
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
