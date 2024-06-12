import 'package:flutter/material.dart';

import '../../../models/Categoria.dart';

class CategoriaAddSrceen extends StatefulWidget {
  final Function(Categoria) onSave;

  CategoriaAddSrceen({required this.onSave});

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<CategoriaAddSrceen> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Categoria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                final newCategory = Categoria(
                  description: _descriptionController.text,
                  isActive: _isActive,
                );
                widget.onSave(newCategory);
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