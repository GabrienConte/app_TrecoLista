import 'dart:convert';

import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../interceptor/logging_interceptor.dart';
import '../models/categoria_model.dart';
import 'commun_service.dart';

class CategoriaService extends AbstractService{
  Client client = InterceptedClient.build(interceptors: [
    LoggerInterceptor(),
  ]);

  Future<List<Categoria>> getCategoriasAtivas() async {
    final headers = await getHeaders();
    final response = await client.get(Uri.parse('${AbstractService.baseUrl}/categoria/ativas'), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Categoria.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar categorias: ${response.reasonPhrase}');
    }
  }
}