import 'package:flutter/material.dart';

import '../../../models/Produto.dart';

class ProdutoFormScreen extends StatefulWidget {
  final Produto? produto;
  final Function(Produto) onSave;

  ProdutoFormScreen({this.produto, required this.onSave});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProdutoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _precoController;
  late TextEditingController _linkController;
  late TextEditingController _plataformaController;
  late String _categoria;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.produto?.nome ?? '');
    _precoController = TextEditingController(text: widget.produto?.preco.toString() ?? '');
    _linkController = TextEditingController(text: widget.produto?.link ?? '');
    _plataformaController = TextEditingController(text: widget.produto?.plataforma ?? '');
    _categoria = widget.produto?.categoria ?? 'Categoria A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.produto == null ? 'Novo Produto' : 'Editar Produto'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um preço';
                  }
                  final parsedValue = double.tryParse(value);
                  if (parsedValue == null || parsedValue <= 0) {
                    return 'Por favor, insira um valor válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _linkController,
                decoration: InputDecoration(labelText: 'Link'),
              ),
              TextFormField(
                controller: _plataformaController,
                decoration: InputDecoration(labelText: 'Plataforma'),
              ),
              DropdownButtonFormField<String>(
                value: _categoria,
                decoration: InputDecoration(labelText: 'Categoria'),
                items: ['Categoria A', 'Categoria B', 'Categoria C']
                    .map((categoria) => DropdownMenuItem(
                  value: categoria,
                  child: Text(categoria),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _categoria = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione uma categoria';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final produto = Produto(
                      nome: _nomeController.text,
                      preco: double.parse(_precoController.text),
                      categoria: _categoria,
                      link: _linkController.text,
                      plataforma: _plataformaController.text,
                    );
                    widget.onSave(produto);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}