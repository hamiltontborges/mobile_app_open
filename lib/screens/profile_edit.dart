import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app_open/models/user.dart';
import 'package:mobile_app_open/utils/courses.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:mobile_app_open/utils/constants.dart';
import 'package:mobile_app_open/utils/form_variables.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// class GetUserName extends StatelessWidget {
//   final String documentId;

//   GetUserName(this.documentId);

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           return Text("Full Name: ${data['email']} ${data['last_name']}");
//         }

//         return Text("loading");
//       },
//     );
//   }
// }

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
  final birthDate = TextEditingController();
  final documentId = FirebaseAuth.instance.currentUser!.uid;
  final fullName = FirebaseAuth.instance.currentUser!.displayName;

  String dropdownValue = '';

  Widget _buildNameForm({fullname}) {
    return TextFormField(
      controller: name,
      keyboardType: TextInputType.emailAddress,
      style: kTextStyleBlue,
      cursorColor: kColorBlue,
      decoration: inputDecorationBlue("Nome completo",
          hintText: "Digite seu nome completo", prefixIcon: Icons.person),
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

  Widget _buildDateBirthForm() {
    return DateTimeField(
      format: DateFormat('dd/MM/yyyy'),
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime.now());
      },
      controller: birthDate,
      style: kTextStyleBlue,
      decoration: InputDecoration(
        focusedBorder: kBorderBlue,
        enabledBorder: kBorderBlue,
        errorBorder: kBorderError,
        focusedErrorBorder: kBorderError,
        prefixIcon: Icon(Icons.date_range, color: kColorBlue),
        labelText: "Data de nascimento",
        labelStyle: kTextStyleBlueBold,
        hintStyle: TextStyle(color: kColorBlue),
      ),
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
      items: courses.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
            value: value, child: Text(value, style: kTextStyleBlue));
      }).toList(),
    );
  }

  Widget _buildAttBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Users().updateUser(user.uid, name.text, birthDate.text,
                DateTime.now(), dropdownValue);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Usuário atualizado com sucesso'),
              backgroundColor: Color.fromARGB(255, 57, 192, 61),
            ));
          }
        },
        icon: Icon(Icons.arrow_upward, color: kColorBlue),
        label: Text("Atualizar", style: kStyleTextButton),
        style: kStyleButton,
      ),
    );
  }

  Widget _buildForm(context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              SizedBox(height: 20.0),
              _buildNameForm(fullname: data['full_name']),
              SizedBox(height: 20.0),
              _buildDateBirthForm(),
              SizedBox(height: 20.0),
            ],
          );
          // return Text("Full Name: ${data['email']} ${data['last_name']}");
        }

        return Text("loading");
      },
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
                      _buildForm(user.uid),
                      _buildDropCourses(),
                      _buildAttBtn(),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
