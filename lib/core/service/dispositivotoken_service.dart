import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

import '../interceptor/logging_interceptor.dart';
import '../models/dispositivo_token.dart';
import 'commun_service.dart';


class DispositivoTokenService extends AbstractService{
  Client client = InterceptedClient.build(interceptors: [
    LoggerInterceptor(),
  ]);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> salvarToken(int usuarioId) async {

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      String? firebaseToken = await _firebaseMessaging.getToken();
      print(firebaseToken);
      if (firebaseToken != null) {
        DispositivoToken dispositivoToken = DispositivoToken(usuarioId: usuarioId, token: firebaseToken);
        final response = await client.post(
          Uri.parse('${AbstractService.baseUrl}/dispositivoToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(dispositivoToken.toJson()),
        );

        if (response.statusCode != 200) {
          throw Exception('Falha ao salvar o token do dispositivo');
        }
      } else {
        print("Erro ao obter o token do Firebase Messaging");
      }
    }
  }
}
