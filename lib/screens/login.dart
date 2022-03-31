import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/screens/forgotPass.dart';
import 'package:mobile_app_open/screens/register.dart';
import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? _rememberMe = false;
  bool? loading = false;

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();


  login() async {
    setState(() => loading == true);
    try {
      await context.read<AuthService>().loginUser(email.text, password.text);
    } on AuthException catch (e) {
      setState(() => loading == false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Widget _buildLogo() {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage('assets/logos/open-unifeob.png')),
      ),
    );
  }

  // Widget _buildTitle() {
  //   return Text(
  //     'Login',
  //     style: TextStyle(
  //       color: kColorWhite,
  //       fontFamily: 'OpenSans',
  //       fontSize: 25.0,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  // }

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
          return 'Informe um email válido';
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
      obscureText: true,
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

  Widget _buildForgetPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => {Navigator.push(context,
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
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckBox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: kColorWhite),
            child: Checkbox(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: _rememberMe,
              checkColor: kColorBlue,
              activeColor: kColorWhite,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            "Lembrar dados",
            style: kLabelStyle,
          )
        ],
      ),
    );
  }

  Widget _buildEnterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            login();
          }
        },
        child: Text("ENTRAR",
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
              borderRadius: BorderRadius.circular(30.0))),
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
        Text(
          'Entrar com',
          style: kLabelStyle,
        )
      ],
    );
  }

  Widget _buildSocialBtn(onTap, AssetImage logo) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)
            ],
            image: DecorationImage(image: logo),
          ),
        ));
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(() => print('Entrou com o Facebook'),
              AssetImage('assets/logos/facebook.png')),
          _buildSocialBtn(() => print('Entrou com o Google'),
              AssetImage('assets/logos/google.png')),
        ],
      ),
    );
  }

  Widget _buildSignUp() {
    return GestureDetector(
      onTap: () => {Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Register()),
                )},
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
          text: 'Não possui cadastro? ',
          style: TextStyle(
            color: kColorWhite,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextSpan(
          text: 'Cadastre-se',
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
                    EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildLogo(),
                    SizedBox(
                      height: 20.0,
                    ),
                    // _buildTitle(),
                    Form(
                      key: formKey,
                      child: Column(children: [
                        SizedBox(height: 30.0),
                        _buildEmailForm(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _buildPasswordForm(),
                        SizedBox(height: 10.0),
                        // _buildPassword(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _buildRememberMeCheckBox(),
                            _buildForgetPassBtn(),
                          ],
                        ),
                        _buildEnterBtn(),
                        _buildEnterWith(),
                        _buildSocialBtnRow(),
                        _buildSignUp(),
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
