import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:treco_lista_app/core/models/plataforma_model.dart';

import '../interceptor/logging_interceptor.dart';
import 'commun_service.dart';

class PlataformaService extends AbstractService{
  Client client = InterceptedClient.build(interceptors: [
    LoggerInterceptor(),
  ]);

  Future<List<Plataforma>> getPlataformas() async {
    final headers = await getHeaders();
    final response = await client.get(Uri.parse('${AbstractService.baseUrl}/plataforma'), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Plataforma.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar plataformas: ${response.reasonPhrase}');
    }
  }
}