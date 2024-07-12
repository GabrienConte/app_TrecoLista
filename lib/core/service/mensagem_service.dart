import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../models/mensagem_model.dart';
import '../persistence/mensagem_persistence.dart';

class MensagemService {
  final MensagemPersistence _mensagemPersistence = MensagemPersistence();

  Future<void> saveMessage(RemoteMessage remoteMessage) async {
    print('SALVAR MENSAGEMM');
    final mensg = Mensagem(
      title: remoteMessage.notification?.title ?? 'No Title',
      body: remoteMessage.notification?.body ?? 'No Body',
    );
    await MensagemPersistence().save(mensg);
  }

  Future<List<Mensagem>> getMessages() async {
    return await _mensagemPersistence.getMensagems();
  }
}