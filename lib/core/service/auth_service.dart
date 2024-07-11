import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:treco_lista_app/core/service/commun_service.dart';

import '../models/dispositivo_token.dart';
import '../models/usuario_model.dart';
import '../persistence/usuario_persistence.dart';
import 'dispositivotoken_service.dart';

class AuthService extends AbstractService{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final DispositivoTokenService _dispositivoTokenService = DispositivoTokenService();


  Future<String?> login(String emailOuLogin, String senha) async {
    final resposta = await http.post(
      Uri.parse('${AbstractService.baseUrl}/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'emailOuLogin': emailOuLogin,
        'senha': senha,
      }),
    );
    if (resposta.statusCode == 200) {
      UsuarioModel u = UsuarioModel.fromJson(jsonDecode(resposta.body));
      new UsuarioPersistence().salvar(u);

      var jsonResponse = jsonDecode(resposta.body);
      String token = jsonResponse['token_access'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      String? firebaseToken = await _firebaseMessaging.getToken();
      if (firebaseToken != null) {
        DispositivoToken dispositivoToken = DispositivoToken(usuarioId: u.id, token: firebaseToken);
        await _dispositivoTokenService.salvarToken(dispositivoToken);
      } else {
        print("Erro ao obter o token do Firebase Messaging");
      }

      return null;
    } else {
      return 'Usuário ou senha inválidos!';
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}