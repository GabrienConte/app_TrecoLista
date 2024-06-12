import 'package:flutter/material.dart';

import '../models/Produto.dart';

class NotificacaoScreen extends StatelessWidget {

  final List<Produto> produtos = [
    Produto(nome: "Produto 1", preco: 29.99, categoria: "Categoria A", link: "assets/mockup.png"),
    Produto(nome: "Produto 2", preco: 59.99, categoria: "Categoria B", link: "assets/mockup.png"),
    Produto(nome: "Produto 3", preco: 19.99, categoria: "Categoria C", link: "assets/mockup.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificações'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return Column(
            children: [
              ListTile(
                leading: Image.asset(
                  produto.link,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(produto.nome),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Preço: R\$${produto.preco.toStringAsFixed(2)}'),
                    SizedBox(height: 4),
                    Text('Texto genérico da notificação.'),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
