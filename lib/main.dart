import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:treco_lista_app/core/service/dispositivotoken_service.dart';
import 'package:treco_lista_app/core/service/mensagem_service.dart';
import 'package:treco_lista_app/screens/android/apptrecolista.dart';

import 'core/service/mensagem_service.dart';
final MensagemService _mensagemService = new MensagemService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onMessage.listen(_handleMessage);
  // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if(Platform.isAndroid){
    debugPrint('app android');
    runApp(Apptrecolista());
  }
  if(Platform.isIOS){
    debugPrint('app ios');
  }
  //runApp(const MyApp());
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print('Handler para mensagens em segundo plano');
//   await _mensagemService.saveMessage(message);
// }
//
// // Handler para mensagens recebidas quando o app está em foreground
// void _handleMessage(RemoteMessage message) async {
//   print('Handler para mensagens recebidas quando o app está em foreground');
//   await _mensagemService.saveMessage(message);
// }
//
// Handler para mensagens abertas quando o app está em segundo plano
// void _handleMessageOpenedApp(RemoteMessage message) async {
//    print('Handler para mensagens abertas quando o app está em segundo plano');
//    await _mensagemService.saveMessage(message);
// }