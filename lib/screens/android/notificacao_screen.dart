import 'package:flutter/material.dart';
import 'package:treco_lista_app/core/models/mensagem_model.dart';
import 'package:treco_lista_app/core/persistence/mensagem_persistence.dart';


class NotificacaoScreen extends StatefulWidget {
  @override
  _NotificacaoScreenState createState() => _NotificacaoScreenState();
}

class _NotificacaoScreenState extends State<NotificacaoScreen> {
  List<Mensagem> mensagens = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    var loadedMessages = await MensagemPersistence().getMensagems();
    setState(() {
      mensagens = loadedMessages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificações'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: mensagens.isEmpty
          ? Center(child: Text('Nenhuma notificação disponível.'))
          : ListView.builder(
        itemCount: mensagens.length,
        itemBuilder: (context, index) {
          final message = mensagens[index];
          return Column(
            children: [
              ListTile(
                title: Text(message.title),
                subtitle: Text(message.body),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
