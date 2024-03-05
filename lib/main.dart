import 'package:flutter/material.dart';
import 'package:medical_app/authantication/loginScreen.dart';
import 'package:medical_app/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: intialroute,
      debugShowCheckedModeBanner: false,
      title: 'Medical App',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const LoginScreen(),
    );
  }
}
