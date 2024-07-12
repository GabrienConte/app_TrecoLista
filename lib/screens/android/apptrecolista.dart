import 'package:flutter/material.dart';
import 'package:treco_lista_app/core/models/usuario_model.dart';
import 'package:treco_lista_app/screens/android/dashboard.dart';
import 'package:treco_lista_app/screens/android/login_screen.dart';

import '../../core/service/auth_service.dart';

class Apptrecolista extends StatelessWidget {
  const Apptrecolista({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();

    if(_authService.getToken() != null){
      return MaterialApp(
        home: Dashboard(),
      );
    } else {
      return MaterialApp(
        home: Login(),
      );
    }

  }
}