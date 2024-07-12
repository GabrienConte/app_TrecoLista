import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:treco_lista_app/core/models/produto_models/produto_model.dart';
import '../interceptor/logging_interceptor.dart';
import '../models/produto_models/produto_card_model.dart';
import '../models/produto_models/produto_create_dto.dart';
import '../models/produto_models/produto_favoritado_model.dart';
import '../models/produto_models/produto_update_dto.dart';
import 'commun_service.dart';

class ProdutoService extends AbstractService{
  Client client = InterceptedClient.build(interceptors: [
    LoggerInterceptor(),
  ]);

  final dio = Dio();

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

  Future<Map<String, dynamic>?> getProdutoInfoScrap(String link) async {
    try {
      final response = await client.post(
        Uri.parse('${AbstractService.baseUrl}/produto/produtoScrap'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'link': link,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load product info');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<String?> criarProduto(ProdutoCreateDto produtoDto) async {
    FormData formData = FormData.fromMap({
      'Link': produtoDto.link,
      'Descricao': produtoDto.descricao,
      'Valor': produtoDto.valor,
      'CategoriaId': produtoDto.categoriaId,
      'PlataformaId': produtoDto.plataformaId,
      'Prioridade': produtoDto.prioridade,
      'IsAvisado': produtoDto.isAvisado,
      // if (produtoDto.imagem != null)
      //   'Imagem': await MultipartFile.fromFile(
      //     produtoDto.imagem!.path,
      //     filename: basename(produtoDto.imagem!.path),
      //   ),
      if (produtoDto.imagemPath != null) 'ImagemPath': produtoDto.imagemPath,
    });
    final response = await dio.post(
        '${AbstractService.baseUrl}/produto',
        data: formData,
        options: Options(headers: await getHeaderToken())
    );

    if (response.statusCode! >= 200 && response.statusCode! <=299) {
      return null; // Registration successful
    } else {
      return "Error";
    }
  }

  Future<bool> atualizaProduto(int id, ProdutoUpdateDto produtoUpdateDto) async {
    try {
      final response = await dio.put(
        '${AbstractService.baseUrl}/produto/$id',
        data: jsonEncode(produtoUpdateDto.toJson()),
        options: Options(
          headers: await getHeaders(),
        ),
      );

      // Verificar o código de resposta aqui, se necessário
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erro ao atualizar produto: $e');
      throw e; // ou tratar conforme necessário
    }
  }
}
