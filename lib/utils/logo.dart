import 'package:flutter/material.dart';

// Logo
logoOpen(size) {
  return Container(
    height: size,
    decoration: BoxDecoration(
      image:
          DecorationImage(image: AssetImage('assets/logos/open-unifeob.png')),
    ),
  );
}