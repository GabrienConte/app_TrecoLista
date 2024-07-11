import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:treco_lista_app/core/service/commun_service.dart';

import '../interceptor/logging_interceptor.dart';

class UsuarioService extends AbstractService{
  Client client = InterceptedClient.build(interceptors: [
    LoggerInterceptor(),
  ]);

  Future<String?> cadastrarUsuario(String login, String email, String senha) async {
    final headers = await getHeaders();
    final response = await client.post(Uri.parse('${AbstractService.baseUrl}/usuario'),
        headers: headers,
        body: jsonEncode(<String, String>{
          'email': email,
          'login': login,
          'senha': senha,
          'tipoUsuario': 'cliente'
        }));
    if (response.statusCode >= 200 && response.statusCode<=299) {
      return null; // Registration successful
    } else {
      return "Error";
    }
  }
}