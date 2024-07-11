import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treco_lista_app/core/models/categoria_model.dart';
import 'package:treco_lista_app/core/models/plataforma_model.dart';
import 'package:treco_lista_app/core/service/categoria_service.dart';
import 'package:treco_lista_app/core/service/plataforma_service.dart';
import 'package:treco_lista_app/core/service/produto_service.dart';

import '../../../core/models/produto_models/produto_model.dart';

class ProdutoFormScreen extends StatefulWidget {
  final String acaoForm;
  final int? produtoId;

  ProdutoFormScreen({required this.acaoForm, this.produtoId});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProdutoFormScreen> {
  final ProdutoService _produtoService = ProdutoService();
  final CategoriaService _categoriaService = CategoriaService();
  final PlataformaService _plataformaService = PlataformaService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _linkController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  int? _plataformaId;
  int? _categoriaId;
  int? _prioridade;
  bool _isAvisado = false;
  String? _imagemPath;
  String? _imagemUrl;
  bool isOutraPlataforma = false;

  // Lista de plataformas e categorias
  List<Plataforma> _plataformas = [];
  List<Categoria> _categorias = [];

  @override
  void initState() {
    super.initState();
    if (widget.acaoForm == 'Editar' || widget.acaoForm == 'Detalhes') {
      // Carregar dados do produto caso esteja em modo de edição ou detalhes
      carregarProduto(widget.produtoId!);
    }
    carregarDropdowns();
  }

  void carregarDropdowns() async{
    try {
      List<Plataforma> plataformasCarregadas = await _plataformaService.getPlataformas();
      setState(() {
        _plataformas = plataformasCarregadas;
      });
      List<Categoria> categoriasCarregadas = await _categoriaService.getCategoriasAtivas();
      setState(() {
        _categorias = categoriasCarregadas;
      });
    } catch (e) {
      print('Erro ao carregar Dropdowns: $e');
    }
  }

  void carregarProduto(int produtoId) {
    _produtoService.carregarProdutoFavoritado(produtoId.toString())
    .then((produto) {
      _linkController.text = produto.link;
      _descricaoController.text = produto.descricao;
      _valorController.text = produto.valor.toString();
      // _linkController.text = produto.link;
      // _descricaoController.text = produto.descricao;
      _plataformaId = produto.plataformaId;
      _categoriaId = produto.categoriaId;
      // _valorController.text = produto.valor.toString();
      _isAvisado = produto.aviso;
      //_imagemUrl = produto.imagemUrl;
      _imagemPath = produto.imagemPath;
      // Outros campos do formulário podem ser preenchidos aqui
    }).catchError((error) {
      print('Erro ao carregar produto: $error');
      // Trate o erro conforme necessário
    });
  }
  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.acaoForm == 'Editar';

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.acaoForm} Produto'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _linkController,
                  decoration: InputDecoration(
                    labelText: 'Link',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: isEditing,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: isEditing || !isOutraPlataforma,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _plataformaId,
                  items: _plataformas.map((plataforma) {
                    return DropdownMenuItem(
                      value: plataforma.id,
                      child: Text(plataforma.descricao),
                    );
                  }).toList(),
                  onChanged: isEditing ? null : (value) {
                    setState(() {
                      _plataformaId = value;
                      isOutraPlataforma = value == 4;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Plataforma',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Valor',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: isEditing || !isOutraPlataforma,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _categoriaId,
                  items: _categorias.map((categoria) {
                    return DropdownMenuItem(
                      value: categoria.id,
                      child: Text(categoria.descricao),
                    );
                  }).toList(),
                  onChanged: isEditing ? null : (value) {
                    setState(() {
                      _categoriaId = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Categoria',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (widget.acaoForm != 'Detalhes') ...[
                  SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    value: 1, // Valor inicial, ajuste conforme necessário
                    items: [
                      DropdownMenuItem(value: 1, child: Text('Baixa')),
                      DropdownMenuItem(value: 5, child: Text('Média')),
                      DropdownMenuItem(value: 10, child: Text('Alta')),
                    ],
                    onChanged: widget.acaoForm != 'Detalhes'
                        ? (value) {
                      setState(() {
                        _prioridade = value;
                      });
                    }
                        : null,
                    decoration: InputDecoration(
                      labelText: 'Prioridade',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  if(!isOutraPlataforma) ...[
                    CheckboxListTile(
                      title: Text('Quer ser avisado ao mudança de preço?'),
                      value: _isAvisado,
                      onChanged: (value) {
                        setState(() {
                          _isAvisado = value!;
                        });
                      },
                    )
                  ],
                    SizedBox(height: 16),
                    _buildImagePreview(),
                  if(isOutraPlataforma) ...[
                    TextButton(
                      onPressed: () {
                        _pickImage();
                      },
                      child: Text('Escolher Imagem'),
                    ),
                  ]
                ],
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: Text('Salvar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (_imagemPath != null) {
      return Image.network(_imagemPath!, width: 250, height: 250,);
    } else {
      return Container(
        height: 100,
        width: 250,
        color: Colors.grey[200],
        child: Center(
          child: Text('Coloque sua imagem aqui'),
        ),
      );
    }
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagemUrl = pickedFile.path;
        _imagemPath = pickedFile.path;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Lógica para enviar os dados do formulário
      // Exemplo de envio de dados para serviço
      // productService.criarProduto(...);
      // productService.editarProduto(...);
      // Utilize os dados dos controllers e variáveis de estado para enviar para a API
      Navigator.of(context).pop(); // Fecha a tela após salvar
    }
  }
}