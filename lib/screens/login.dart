import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/utils/constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool? _rememberMe = false;

  Widget _buildLogo() {
    return Container(
      height: 80.0,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage('assets/logos/open-unifeob.png')),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Login',
      style: TextStyle(
        color:  kColorWhite,
        fontFamily: 'OpenSans',
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEmailForm() {
    return TextFormField(
      style: TextStyle(
        color:  kColorWhite,
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  kColorWhite, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  kColorWhite, width: 1.0),
        ),
        prefixIcon:
            Icon(Icons.email, color:  kColorWhite),
        prefixIconColor:  kColorWhite,
        labelText: "Email",
        labelStyle: TextStyle(color:  kColorWhite),
        hintText: "Digite seu email",
        hintStyle: TextStyle(color:  kColorWhite),
      ),
    );
  }

  Widget _buildPasswordForm() {
    return TextFormField(
      style: TextStyle(
        color:  kColorWhite,
      ),
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  kColorWhite, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  kColorWhite, width: 1.0),
        ),
        prefixIcon:
            Icon(Icons.lock, color:  kColorWhite),
        prefixIconColor:  kColorWhite,
        labelText: "Senha",
        labelStyle: TextStyle(color: kColorWhite),
        hintText: "Digite sua senha",
        hintStyle: TextStyle(color:  kColorWhite),
      ),
    );
  }

  Widget _buildForgetPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Esqueci minha senha acionado'),
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
            data: ThemeData(unselectedWidgetColor:  kColorWhite),
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
        onPressed: () => {},
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
          backgroundColor:
              MaterialStateProperty.all(kColorYellow),
        ),
      ),
    );
  }

  Widget _buildEnterWith() {
    return Column(
      children: <Widget>[
        Text(
          '- OU -',
          style: TextStyle(color:  kColorWhite, fontWeight: FontWeight.w500),
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
            color:  kColorWhite,
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
              AssetImage('assets/logos/facebook.jpg')),
          _buildSocialBtn(() => print('Entrou com o Google'),
              AssetImage('assets/logos/google.jpg')),
        ],
      ),
    );
  }

  Widget _buildNull() {
    return Container();
  }

  Widget _buildSignUp() {
    return GestureDetector(
      onTap: () => {},
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
                    _buildTitle(),
                    Form(
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
