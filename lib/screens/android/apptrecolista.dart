import 'package:flutter/material.dart';
import 'package:treco_lista_app/screens/android/login_screen.dart';

class Apptrecolista extends StatelessWidget {
  const Apptrecolista({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}