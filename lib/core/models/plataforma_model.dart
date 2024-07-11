class Plataforma {
  final int id;
  final String descricao;

  Plataforma({required this.id, required this.descricao});

  factory Plataforma.fromJson(Map<String, dynamic> json) {
    return Plataforma(
      id: json['id'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
    };
  }
}