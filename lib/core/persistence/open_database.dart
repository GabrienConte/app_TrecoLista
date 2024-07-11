import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:treco_lista_app/core/persistence/usuario_persistence.dart';

Future<void> clearDatabase() async {
  final String path = join(await getDatabasesPath(), 'trecolista.db');

  // Exclui o arquivo do banco de dados, se existir
  await deleteDatabase(path);
  print('Banco de dados anterior removido.');
}

Future<Database> getDatabase() async{
  //await clearDatabase();

  return openDatabase( join(await getDatabasesPath(), 'trecolista.db'),
      onCreate: (db, version) async{


        print(UsuarioPersistence.createTabelaUsuario);
        List<String> queryes = [
          UsuarioPersistence.createTabelaUsuario
        ];

        print('getDatabasesPath(): '+ getDatabasesPath().toString());
        for(String sql in queryes){
          print('sql: '+sql);
          db.execute(sql);
        }
      },version: 1);
}