import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:provider/provider.dart';

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

  Widget _buildLogo() {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage('assets/logos/open-unifeob.png')),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Cadastrar',
      style: TextStyle(
        color: kColorWhite,
        fontFamily: 'OpenSans',
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
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

  Widget _buildPasswordForm() {
    return TextFormField(
      controller: password,
      style: TextStyle(
        color: kColorWhite,
      ),
      cursorColor: kColorWhite,
      obscureText: true,
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
        prefixIcon: Icon(Icons.lock, color: kColorWhite),
        prefixIconColor: kColorWhite,
        labelText: "Senha",
        labelStyle: TextStyle(color: kColorWhite, fontWeight: FontWeight.bold),
        hintText: "Digite sua senha",
        hintStyle: TextStyle(color: kColorWhite),
      ),
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
      style: TextStyle(
        color: kColorWhite,
      ),
      cursorColor: kColorWhite,
      obscureText: true,
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
        prefixIcon: Icon(Icons.lock, color: kColorWhite),
        prefixIconColor: kColorWhite,
        labelText: "Confirmar senha",
        labelStyle: TextStyle(color: kColorWhite, fontWeight: FontWeight.bold),
        hintText: "Digite navamente sua senha",
        hintStyle: TextStyle(color: kColorWhite),
      ),
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
        icon: Icon(
          Icons.person_add,
          color: kColorBlue,
        ),
        label: Text("CADASTRAR",
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
      ),
    );
  }

  Widget _buildEnterWith() {
    return Column(
      children: <Widget>[
        Text(
          '- OU -',
          style: TextStyle(color: kColorWhite, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget _buildSocialBtn() {
    return ElevatedButton.icon(
      icon: Image.asset('assets/logos/google.png', height: 30.0),
      style: ElevatedButton.styleFrom(
        primary: kColorWhite,
        onPrimary: kColorBlue,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: () {},
      label: Text(
        'Entrar com Google',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSignUp() {
    return GestureDetector(
      onTap: () => {Navigator.pop(context)},
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
          text: 'Já possui cadastro? ',
          style: TextStyle(
            color: kColorWhite,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextSpan(
          text: 'Entre',
          style: TextStyle(
            color: kColorYellow,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ])),
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
            icon: Icon(Icons.login, color: kColorYellow,),
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
                padding:
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildLogo(),
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
                        SizedBox(height: 10.0),
                        _buildEnterWith(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _buildSocialBtn(),
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
