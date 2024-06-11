import 'dart:io';

import 'package:flutter/material.dart';
import 'package:treco_lista_app/screens/android/apptrecolista.dart';

void main() {
  if(Platform.isAndroid){
    debugPrint('app android');
    runApp(Apptrecolista());
  }
  if(Platform.isIOS){
    debugPrint('app ios');
  }
  //runApp(const MyApp());
}