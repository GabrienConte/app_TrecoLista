import 'package:flutter/material.dart';
import 'package:treco_lista_app/core/service/usuario_service.dart';
import 'package:treco_lista_app/screens/android/login_screen.dart';

class CadastroUsuario extends StatefulWidget {

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final UsuarioService _usuarioService = UsuarioService();

  void _cadastrar() async {
    final login = _loginController.text;
    final email = _emailController.text;
    final senha = _senhaController.text;

    final errorMessage = await _usuarioService.cadastrarUsuario(login, email, senha);

    if (errorMessage == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Usuário cadastrado com sucesso!'),
        backgroundColor: Colors.green,
      ));
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Login()
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao cadastrar usuario'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Usuário'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _loginController,
                  decoration: InputDecoration(
                    labelText: 'Login',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _cadastrar,
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
