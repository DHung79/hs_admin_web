import 'package:flutter/material.dart';
import 'package:hs_admin_web/screens/login_page.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      home: const LoginPage(),
    );
  }
}
