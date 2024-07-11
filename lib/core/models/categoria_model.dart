class Categoria {
  final int id;
  final String descricao;
  final bool ativo;

  Categoria({required this.id, required this.descricao, required this.ativo});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      descricao: json['descricao'],
      ativo: json['ativo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'ativo': ativo,
    };
  }
}