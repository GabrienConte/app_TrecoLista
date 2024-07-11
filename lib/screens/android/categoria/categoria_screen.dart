import 'package:flutter/material.dart';
import 'package:treco_lista_app/core/service/categoria_service.dart';
import 'package:treco_lista_app/screens/android/Categoria/categoria_detalhe_screen.dart';

import '../../../core/models/categoria_model.dart';
import 'categoria_add_screen.dart';

class CategoriaSrceen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoriaSrceen> {
  final CategoriaService _categoriaService = CategoriaService();
  List<Categoria> categorias = [];

  String searchQuery = "";

  void _carregarCategorias() async {
    try {
      List<Categoria> categoriasCarregadas = await _categoriaService.getCategoriasAtivas();
      setState(() {
        categorias = categoriasCarregadas;
      });
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    List<Categoria> filteredCategories = categorias
        .where((categoria) => categoria.descricao
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
                  final categoria = filteredCategories[index];
                  return ListTile(
                    title: Text(categoria.descricao),
                    trailing: Icon(
                      categoria.ativo ? Icons.check_circle : Icons.cancel,
                      color: categoria.ativo ? Colors.green : Colors.red,
                    ),
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => CategoriaDetalheSrceen(
                    //         categoria: categoria
                    //       ),
                    //     ),
                    //   );
                    // },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => CategoriaAddSrceen(onSave: (categoria) {
      //         setState(() {
      //           categories.add(categoria);
      //         });
      //       })),
      //     );
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}