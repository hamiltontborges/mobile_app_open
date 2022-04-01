import 'package:flutter/material.dart';
import 'package:mobile_app_open/utils/constants.dart';


inputDecoration(icon, labelText, hintText) { 
  InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: kColorBlue, width: 1.0),
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
      prefixIcon: Icon(icon, color: kColorWhite),
      prefixIconColor: kColorWhite,
      labelText: labelText,
      labelStyle: TextStyle(color: kColorWhite, fontWeight: FontWeight.bold),
      hintText: hintText,
      hintStyle: TextStyle(color: kColorWhite),
    );
  }
