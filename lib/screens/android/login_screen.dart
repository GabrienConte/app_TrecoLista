import 'package:flutter/material.dart';
import 'package:treco_lista_app/screens/android/cadastro_screen.dart';
import 'package:treco_lista_app/screens/android/dashboard.dart';

import '../../core/service/auth_service.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailOuLoginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Treco lista'),
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
                  controller: _emailOuLoginController,
                  decoration: InputDecoration(
                    labelText: 'Email ou Login',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 8),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String? error = await _authService.login(_emailOuLoginController.text, _passwordController.text);
                    if (error == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Usuário logado com sucesso!'),
                        backgroundColor: Colors.green,
                      ));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Dashboard()
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(error),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CadastroUsuario()
                    ));
                  },
                  child: Text('Não tem cadastro? Cadastre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
