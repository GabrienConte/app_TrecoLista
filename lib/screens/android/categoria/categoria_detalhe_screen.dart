import 'package:flutter/material.dart';

import '../../../models/Categoria.dart';

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
    _descriptionController = TextEditingController(text: widget.category.description);
    _isActive = widget.category.isActive;
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
                  description: _descriptionController.text,
                  isActive: _isActive,
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