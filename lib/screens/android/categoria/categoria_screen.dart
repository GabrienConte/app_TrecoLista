import 'package:flutter/material.dart';
import 'package:treco_lista_app/screens/android/Categoria/categoria_detalhe_screen.dart';

import '../../../models/Categoria.dart';
import 'categoria_add_screen.dart';

class CategoriaSrceen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoriaSrceen> {
  final List<Categoria> categories = [
    Categoria(description: "Categoria 1", isActive: true),
    Categoria(description: "Categoria 2", isActive: false),
    Categoria(description: "Categoria 3", isActive: true),
    // Adicione mais categorias conforme necessário
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Categoria> filteredCategories = categories
        .where((category) => category.description
        .toLowerCase()
        .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = filteredCategories[index];
                  return ListTile(
                    title: Text(category.description),
                    trailing: Icon(
                      category.isActive ? Icons.check_circle : Icons.cancel,
                      color: category.isActive ? Colors.green : Colors.red,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriaDetalheSrceen(
                            category: category
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CategoriaAddSrceen(onSave: (category) {
              setState(() {
                categories.add(category);
              });
            })),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}