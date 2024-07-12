import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/mensagem_model.dart';

class MensagemPersistence {
  Future<void> save(Mensagem message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? mensagens = prefs.getStringList('mensagens') ?? [];
    mensagens.add('${message.title}:${message.body}');
    await prefs.setStringList('messages', mensagens);
  }

  Future<List<Mensagem>> getMensagems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> notificacoesSalvas = prefs.getStringList('mensagens') ?? [];
    return notificacoesSalvas.map((jsonString) => Mensagem.fromJson(jsonDecode(jsonString))).toList();
  }
}