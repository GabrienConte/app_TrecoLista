import 'package:flutter/material.dart';

import '../../../core/models/categoria_model.dart';

class CategoriaDetalheSrceen extends StatefulWidget {
  final Categoria category;

  CategoriaDetalheSrceen({required this.category});

  @override
  _CategoriaDetalheSrceenState createState() => _CategoriaDetalheSrceenState();
}

class _CategoriaDetalheSrceenState extends State<CategoriaDetalheSrceen> {
  late TextEditingController _descriptionController;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.category.descricao);
    _isActive = widget.category.ativo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Categoria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Ativo:'),
                Switch(
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final updatedCategory = Categoria(
                  id: 0,
                  descricao: _descriptionController.text,
                  ativo: _isActive,
                );
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}