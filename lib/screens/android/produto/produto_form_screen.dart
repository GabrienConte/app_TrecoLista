import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:treco_lista_app/core/models/categoria_model.dart';
import 'package:treco_lista_app/core/models/plataforma_model.dart';
import 'package:treco_lista_app/core/service/categoria_service.dart';
import 'package:treco_lista_app/core/service/plataforma_service.dart';
import 'package:treco_lista_app/core/service/produto_service.dart';
import 'package:treco_lista_app/screens/android/dashboard.dart';

import '../../../core/models/produto_models/produto_create_dto.dart';
import '../../../core/models/produto_models/produto_model.dart';
import '../../../core/models/produto_models/produto_update_dto.dart';

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
  int? _prioridade = 1;
  bool _isAvisado = false;
  String _imagemPath = '';
  bool isOutraPlataforma = false;

  // Lista de plataformas e categorias
  List<Plataforma> _plataformas = [];
  List<Categoria> _categorias = [];

  @override
  void initState() {
    super.initState();
    if (widget.acaoForm == 'Editar' || widget.acaoForm == 'Detalhes') {
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
      _plataformaId = produto.plataformaId;
      _categoriaId = produto.categoriaId;
      _prioridade = produto.prioridade;
      _isAvisado = produto.aviso;
      _imagemPath = produto.imagemPath;
    }).catchError((error) {
      print('Erro ao carregar produto: $error');
    });
  }

  void _carregarProdutoInfo(String link) async {
    try {
      Map<String, dynamic>? produtoInfo = await _produtoService.getProdutoInfoScrap(link);
      if (produtoInfo != null) {
        setState(() {
          _descricaoController.text = produtoInfo['descricao'] ?? '';
          _valorController.text = produtoInfo['valorConvertido'].toString();
          _imagemPath = produtoInfo['imagemPath'] ?? '';
          String? plataformaNome = produtoInfo['plataforma'];
          if (plataformaNome != null) {
            Plataforma? plataformaSelecionada = _plataformas.firstWhere(
                  (plataforma) => plataforma.descricao == plataformaNome,
              orElse: () => Plataforma(id: -1, descricao: ''),
            );
            if (plataformaSelecionada.id != -1) {
              _plataformaId = plataformaSelecionada.id;
            }
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Falha ao carregar detalhes do produto!'),
          backgroundColor: Colors.red,
        ));
        print('Falha ao carregar detalhes do produto');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Envie um link válido!'),
        backgroundColor: Colors.red,
      ));
      print('Erro ao conectar ao servidor: $e');
    }
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o link';
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    _carregarProdutoInfo(_linkController.text);
                  },
                  readOnly: isEditing,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _descricaoController,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a descrição';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma plataforma';
                    }
                    return null;
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o valor';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma categoria';
                    }
                    return null;
                  },
                ),
                if (widget.acaoForm != 'Detalhes') ...[
                  SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    value: _prioridade, // Valor inicial, ajuste conforme necessário
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
    if (_imagemPath != '') {
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
        _imagemPath = pickedFile.path;
      });
    }
  }

  Future<void> _submitForm() async {
      try {
        if (_formKey.currentState!.validate()) {
          if (widget.produtoId != null) {
            // Modo de edição: chama a função onUpdatePressed com os dados atualizados
            final produtoUpdateDto = ProdutoUpdateDto(
              categoriaId: _categoriaId!,
              plataformaId: _plataformaId!,
              prioridade: _prioridade!,
              isAvisado: _isAvisado,
            );
            final resposta = await _produtoService.atualizaProduto(
                widget.produtoId!, produtoUpdateDto);
            if (resposta) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Produto atualizado com sucesso!'),
                backgroundColor: Colors.green,
              ));
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Dashboard()
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Erro ao atualizar produto!'),
                backgroundColor: Colors.red,
              ));
            }
          } else {
            // Modo de criação: chama a função onCreatePressed com os dados do novo produto
            final produtoCreateDto = ProdutoCreateDto(
              link: _linkController.text,
              descricao: _descricaoController.text,
              valor: _valorController.text.replaceAll('.', ','),
              categoriaId: _categoriaId!,
              plataformaId: _plataformaId!,
              prioridade: _prioridade!,
              isAvisado: _isAvisado,
              imagemPath: _imagemPath
            );
            final resposta = await _produtoService.criarProduto(
                produtoCreateDto);
            if (resposta == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Produto cadastrado com sucesso!'),
                backgroundColor: Colors.green,
              ));
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Dashboard()
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Erro ao cadastrar produto!'),
                backgroundColor: Colors.red,
              ));
            }
          }
        }
      } catch (e) {
        // Lidar com exceções
        print('Erro ao criar produto: $e');
      }
  }
}