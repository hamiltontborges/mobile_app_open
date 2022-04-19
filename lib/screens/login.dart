import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/utils/snackbar.dart';
import 'package:mobile_app_open/utils/validators.dart';
import 'package:provider/provider.dart';

import 'package:mobile_app_open/screens/forgot_pass.dart';
import 'package:mobile_app_open/screens/register.dart';
import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:mobile_app_open/utils/google_login_btn.dart';
import 'package:mobile_app_open/utils/form_variables.dart';
import 'package:mobile_app_open/utils/logo.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? _rememberMe = false;
  bool? loading = false;
  bool obscureText = true;

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  login() async {
    setState(() => loading == true);
    try {
      await context.read<AuthService>().loginUser(email.text, password.text);
      snackBar(context, "Bem-vindo(a) ${email.text}!", color: Colors.green);
    } on AuthException catch (e) {
      setState(() => loading == false);
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

  Widget _buildPasswordForm() {
    return TextFormField(
      controller: password,
      style: kTextStyleWhite,
      obscureText: true,
      cursorColor: kColorWhite,
      decoration: inputDecorationWhite(Icons.lock, 'Senha', 'Digite sua senha'),
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

  Widget _buildForgetPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassword()),
          )
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.only(right: 0.0),
          ),
        ),
        child: Text(
          'Esqueceu sua senha?',
          style: kTextLabelStyle,
        ),
      ),
    );
  }

  // Widget _buildRememberMeCheckBox() {
  //   return Container(
  //     height: 20.0,
  //     child: Row(
  //       children: <Widget>[
  //         Theme(
  //           data: ThemeData(unselectedWidgetColor: kColorWhite),
  //           child: Checkbox(
  //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //             value: _rememberMe,
  //             checkColor: kColorBlue,
  //             activeColor: kColorWhite,
  //             onChanged: (value) {
  //               setState(() {
  //                 _rememberMe = value;
  //               });
  //             },
  //           ),
  //         ),
  //         Text(
  //           "Lembrar dados",
  //           style: kTextLabelStyle,
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildEnterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            login();
          }
        },
        icon: Icon(
          Icons.login,
          color: kColorBlue,
        ),
        label: Text("ENTRAR", style: kStyleTextButton),
        style: kStyleButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorDarkBlue,
        title: Text('Login'),
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(
                Icons.person_add,
                color: kColorYellow,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              label: Text(
                'Cadastrar-se',
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
                    logoOpen(100.0),
                    SizedBox(height: 20.0),
                    // _buildTitle(),
                    Form(
                      key: formKey,
                      child: Column(children: [
                        SizedBox(height: 30.0),
                        _buildEmailForm(),
                        SizedBox(height: 20.0),
                        _buildPasswordForm(),
                        SizedBox(height: 10.0),
                        // _buildPassword(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            // _buildRememberMeCheckBox(),
                            _buildForgetPassBtn(),
                          ],
                        ),
                        _buildEnterBtn(),
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
