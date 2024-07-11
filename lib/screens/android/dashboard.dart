import 'package:flutter/material.dart';
import 'package:treco_lista_app/screens/android/produto/produto_form_screen.dart';
import 'package:treco_lista_app/screens/android/notificacao_screen.dart';
import '../../core/models/produto_models/produto_card_model.dart';
import '../../core/service/produto_service.dart';
import '../../src/fill_image_card.dart';
import 'Categoria/categoria_screen.dart';
import 'login_screen.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ProdutoService _produtoService = ProdutoService();
  final TextEditingController _searchController = TextEditingController();
  List<ProdutoCard> produtoCards = [];

  void _carregarProdutos() async {
    try {
      List<ProdutoCard> produtosCarregados = await _produtoService.getProdutoCards();
      setState(() {
        produtoCards = produtosCarregados;
      });
    } catch (e) {
      print('Erro ao carregar produtos: $e');
    }
  }

  void _navigateToProductForm(String acaoForm, int? produtoId) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProdutoFormScreen(acaoForm: acaoForm, produtoId: produtoId),
    ));
  }

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToProductForm('Criar', null),
        icon: Icon(Icons.add),
        label: Text("Produto"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Implement search logic
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: produtoCards.map((produtoCard) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      _navigateToProductForm('Editar', produtoCard.produtoId);
                    },
                    child: FillImageCard(
                      width: 250,
                      heightImage: 160,
                      imageUrl: produtoCard.imagemPath,
                      tags: [
                        _tag(produtoCard.isFavoritado ? 'Favoritado' : 'Não Favoritado', () {}),
                      ],
                      title: _title(produtoCard.descricao),
                      description: _content(produtoCard.valor),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Icon(
                Icons.face,
                size: 48.0,
                color: Colors.white,
              ),
              otherAccountsPictures: [
                ListTile(
                  leading: Icon(Icons.notifications, color: Colors.white,),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificacaoScreen()
                  )),
                )
              ],
              accountName: Text('Gabriel Conte'),
              accountEmail: Text('gabrielconte0@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Seus Produtos'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Dashboard()
              )),
            ),
            // ListTile(
            //   leading: Icon(Icons.shopping_bag),
            //   title: Text('Outros Produtos'),
            //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => Dashboard()
            //   )),
            // ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categorias'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CategoriaSrceen()
              )),
            ),
            Divider(),
            ListTile(
              title: Text('Treco Lista'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Login()
              )),
            )
          ],
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _content(double price) {
    return Text(
      'Preço: R\$${price.toStringAsFixed(2)}',
      style: TextStyle(color: Colors.black),
    );
  }

  Widget _tag(String tag, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.green,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          tag,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
