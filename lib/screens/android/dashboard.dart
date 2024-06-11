import 'package:flutter/material.dart';
import 'package:treco_lista_app/screens/android/login_screen.dart';
import '../../src/fill_image_card.dart';

class Dashboard extends StatelessWidget {
  // This controller will store the value of the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text("Produto"),
      ),
      body: SingleChildScrollView(
        //color: Colors.blue,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // Add padding around the search bar
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // Use a Material design search bar
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Pesquisar...',
                    // Add a clear button to the search bar
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
                    ),
                    // Add a search icon or button to the search bar
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Perform the search here
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
                children: [
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        FillImageCard(
                          width: 250,
                          heightImage: 160,
                          imageProvider: AssetImage('assets/mockup.png'),
                          tags: [
                            _tag('Category', () {}),
                            _tag('Product', () {}),
                          ],
                          title: _title(),
                          description: _content(),
                        ),
                        const SizedBox(height: 12),
                        FillImageCard(
                          width: 250,
                          heightImage: 160,
                          imageProvider: AssetImage('assets/mockup.png'),
                          tags: [
                            _tag('Category', () {}),
                            _tag('Product', () {}),
                          ],
                          title: _title(),
                          description: _content(),
                        ),
                        const SizedBox(height: 12),
                        FillImageCard(
                          width: 250,
                          heightImage: 160,
                          imageProvider: AssetImage('assets/mockup.png'),
                          tags: [
                            _tag('Category', () {}),
                            _tag('Product', () {}),
                          ],
                          title: _title(),
                          description: _content(),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
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
                  onTap: () => (),
                )
              ],
              accountName: Text('Gabriel Conte'),
              accountEmail: Text('gabrielconte0@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Seus Produtos'),
              onTap: () => (),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('Outros Produtos'),
              onTap: () => (),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categorias'),
              onTap: () => (),
            ),
            Divider(),
            ListTile(
              title: Text('Treco Lista'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Login()
                ))
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _msgSuperiorTXT() {
    return Container(
      color: Colors.amberAccent,
      alignment: Alignment.topRight,
      padding: const EdgeInsets.all(8.0),
      child: Text('Texto'),
    );
  }
}

Widget _title({Color? color}) {
  return Text(
    'Card title',
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
  );
}

Widget _content({Color? color}) {
  return Text(
    'This a card description',
    style: TextStyle(color: color),
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