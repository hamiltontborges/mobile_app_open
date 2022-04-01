import 'package:flutter/material.dart';
import 'package:mobile_app_open/utils/constants.dart';

// Styles variables
final kTextLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

// Text Blue
final kTextStyleBlue = TextStyle(
  color: kColorBlue,
  fontFamily: 'OpenSans',
);

// Text White
final kTextStyleWhite = TextStyle(
  color: kColorWhite,
  fontFamily: 'OpenSans',
);

// Text White Bold
final kTextStyleWhiteBold = TextStyle(
  color: kColorWhite,
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.bold,
);

//Input Border White
final kBorderWhite = OutlineInputBorder(
  borderSide: BorderSide(color: kColorWhite),
);

// Input Border Red
final kBorderError = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.red),
);

final kStyleTextButton = TextStyle(
  color: kColorBlue,
  letterSpacing: 1.5,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kStyleButton = ButtonStyle(
  elevation: MaterialStateProperty.all(5.0),
  padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
  backgroundColor: MaterialStateProperty.all(kColorYellow),
);

// FUNCTIONS

// inputDecoration -> TextFormField
inputDecoration(prefixIcon, labelText, hintText) {
  return InputDecoration(
    focusedBorder: kBorderWhite,
    enabledBorder: kBorderWhite,
    errorBorder: kBorderError,
    focusedErrorBorder: kBorderError,
    prefixIcon: Icon(prefixIcon, color: kColorWhite),
    prefixIconColor: kColorWhite,
    labelText: labelText,
    labelStyle: TextStyle(color: kColorWhite, fontWeight: FontWeight.bold),
    hintText: hintText,
    hintStyle: TextStyle(color: kColorWhite),
  );
}

alternativeEnterDivider() {
  return Row(children: <Widget>[
    Expanded(child: Divider(thickness: 1, endIndent: 10,color: kColorWhite,)),
    Text("OU", style: kTextStyleWhiteBold,),
    Expanded(child: Divider(thickness: 1, indent: 10,color: kColorWhite,)),
  ],
  );
}