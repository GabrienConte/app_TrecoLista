import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:treco_lista_app/core/models/produto_models/produto_model.dart';
import '../interceptor/logging_interceptor.dart';
import '../models/produto_models/produto_card_model.dart';
import '../models/produto_models/produto_favoritado_model.dart';
import 'commun_service.dart';

class ProdutoService extends AbstractService{
  Client client = InterceptedClient.build(interceptors: [
    LoggerInterceptor(),
  ]);

  Future<List<ProdutoCard>> getProdutoCards() async {
    final headers = await getHeaders();
    final response = await client.get(Uri.parse('${AbstractService.baseUrl}/produto/Favoritados'), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProdutoCard.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar produtos: ${response.reasonPhrase}');
    }
  }

  Future<ProdutoFavoritado> carregarProdutoFavoritado (String id) async {
    final headers = await getHeaders();
    final response = await client.get(Uri.parse('${AbstractService.baseUrl}/produto/$id/favoritado'), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return ProdutoFavoritado.fromJson(json);
    } else {
      throw Exception('Falha ao carregar produto: ${response.reasonPhrase}');
    }
  }
}
