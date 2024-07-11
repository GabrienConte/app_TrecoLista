import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

import '../interceptor/logging_interceptor.dart';
import '../models/dispositivo_token.dart';
import 'commun_service.dart';


class DispositivoTokenService extends AbstractService{
  Client client = InterceptedClient.build(interceptors: [
    LoggerInterceptor(),
  ]);

  Future<void> salvarToken(DispositivoToken dispositivoToken) async {
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
  }
}
