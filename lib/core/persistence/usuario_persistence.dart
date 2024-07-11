import 'package:sqflite/sqflite.dart';

import '../models/usuario_model.dart';
import 'open_database.dart';

class UsuarioPersistence{

  static const String _nomeTabela = 'usuario';
  static const String _col_id = 'id';
  static const String _col_email = 'email';
  static const String _col_login = 'login';
  static const String _col_senha = 'senha';
  static const String _col_tipousuario = 'tipousuario';


  static const String createTabelaUsuario = 'CREATE TABLE $_nomeTabela ('
      '$_col_id INTEGER PRIMARY KEY, '
      '$_col_login TEXT, '
      '$_col_email TEXT, '
      '$_col_senha TEXT, '
      '$_col_tipousuario TEXT)';

  salvar(UsuarioModel u) async{
    final db = await getDatabase();

    await db.insert(_nomeTabela, u.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<UsuarioModel>?> listar() async{
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_nomeTabela);

    List.generate(maps.length, (i){
      //return UsuarioModel.fromJson(maps[i]);
      return UsuarioModel(
          id: maps[i]["id"],
          email: maps[i]["email"],
          login: maps[i]["login"],
          senha: maps[i]["senha"]
      );
    });

  }
}