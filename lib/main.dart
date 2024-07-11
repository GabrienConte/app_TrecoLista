import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:treco_lista_app/core/service/dispositivotoken_service.dart';
import 'package:treco_lista_app/screens/android/apptrecolista.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if(Platform.isAndroid){
    debugPrint('app android');
    runApp(Apptrecolista());
  }
  if(Platform.isIOS){
    debugPrint('app ios');
  }
  //runApp(const MyApp());
}