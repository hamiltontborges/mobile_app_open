import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/screens/login.dart';
import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  validateEmail(email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }

  Widget _buildLogo() {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage('assets/logos/open-unifeob.png')),
      ),
    );
  }

  Widget _buildEmailForm() {
    return TextFormField(
      controller: email,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: kColorWhite,
      ),
      cursorColor: kColorWhite,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kColorWhite, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kColorWhite, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        prefixIcon: Icon(Icons.email, color: kColorWhite),
        prefixIconColor: kColorWhite,
        labelText: "Email",
        labelStyle: TextStyle(color: kColorWhite, fontWeight: FontWeight.bold),
        hintText: "Digite seu email",
        hintStyle: TextStyle(color: kColorWhite),
      ),
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

  Widget _buildResetBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(Icons.send_outlined, color: kColorBlue),
        label: Text("Recuperar senha",
            style: TextStyle(
                color: kColorBlue,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans')),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(5.0),
          padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
          backgroundColor: MaterialStateProperty.all(kColorYellow),
        ),
        onPressed: () {
          resetPassword();
        },
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
                    _buildLogo(),
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

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email de recuperação de senha enviado.")));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
      Navigator.of(context).pop();
    }
  }
}
