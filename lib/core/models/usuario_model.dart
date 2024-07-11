

class UsuarioModel{
  final int id;
  final String? email;
  final String? senha;
  final String? login;
  final String? tipousuario;
  final String? token;

  UsuarioModel({required this.id, this.email, this.senha, this.login, this.tipousuario, this.token});


  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'login': login,
      'senha': senha,
      'tipousuario': tipousuario
    };
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json){
    return UsuarioModel(
      id: json['usuario']['id'],
      email: json['usuario']['email'],
      login: json['usuario']['login'],
      senha: json['usuario']['senha'],
      tipousuario: json['usuario']['tipoUsuario'],
      token: json['token_access'],
    );
  }

  /*Map<String, dynamic> fromJson(){
    return UsuarioModel(id: )
  }*/

  @override
  String toString() {
    return 'UsuarioModel{id: $id, email: $email, senha: $senha, tipo usuario: $tipousuario, login: $login, token: $token}';
  }
}