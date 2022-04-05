import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/models/user.dart';
import 'package:mobile_app_open/utils/courses.dart';

import 'package:mobile_app_open/utils/constants.dart';
import 'package:mobile_app_open/utils/form_variables.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool? loading = false;
  final user = FirebaseAuth.instance.currentUser!;

  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  String dropdownValue = "";

  Widget _buildEmailForm() {
    return TextFormField(
      enabled: false,
      controller: email,
      keyboardType: TextInputType.emailAddress,
      style: kTextStyleBlue,
      cursorColor: kColorBlue,
      decoration: inputDecorationBlue(Icons.email, "${user.email}"),
    );
  }

  Widget _buildName({name}) {
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.emailAddress,
      style: kTextStyleBlue,
      cursorColor: kColorBlue,
      decoration: inputDecorationBlue(Icons.person, "Nome completo",
          hintText: "Digite seu nome completo"),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Informe seu nome completo';
        } else if (value.length < 6) {
          return 'Seu nome deve ter no mínimo 10 caracteres';
        }
        return null;
      },
    );
  }

  Widget _buildDropCourses() {
    return DropdownButtonFormField(
      style: kTextStyleBlue,
      decoration: InputDecoration(
        focusedBorder: kBorderBlue,
        enabledBorder: kBorderBlue,
        errorBorder: kBorderError,
        focusedErrorBorder: kBorderError,
        // prefixIcon: Icon(color: kColorBlue),
        prefixIconColor: kColorBlue,
        labelText: "Curso",
        labelStyle: TextStyle(color: kColorBlue, fontWeight: FontWeight.bold),
        hintText: "Selecione o curso",
        hintStyle: TextStyle(color: kColorBlue),
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "can't empty";
        } else {
          return null;
        }
      },
      items: courses.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
    );
  }

  Widget _buildAttBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          if (formKey.currentState!.validate()) {}
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
                        _buildEmailForm(),
                        SizedBox(height: 20.0),
                        _buildDropCourses(),
                        SizedBox(height: 20.0),
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
