import 'package:flutter/material.dart';
import 'package:mobile_app_open/utils/constants.dart';

appbarLogin(page, onPressed, icon, label) {
  return AppBar(
    backgroundColor: kColorDarkBlue,
    title: Text(page),
    actions: <Widget>[
      TextButton.icon(
          icon: Icon(
            icon,
            color: kColorYellow,
          ),
          onPressed: onPressed,
          label: Text(
            label,
            style: TextStyle(color: kColorYellow, fontSize: 16),
          )),
    ],
  );
}
