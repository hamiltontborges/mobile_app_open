import 'package:mobile_app_open/screens/home.dart';
import 'package:mobile_app_open/screens/login.dart';
import 'package:mobile_app_open/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile_app_open/services/auth_check.dart';
import 'package:mobile_app_open/services/auth_service.dart';
import 'package:mobile_app_open/services/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
    ],
    child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => Login(),
        '/register': (BuildContext context) => Register(),
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}
