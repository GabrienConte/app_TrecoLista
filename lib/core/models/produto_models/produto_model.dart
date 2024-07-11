class Produto {
  final int id;
  final String descricao;
  final String link;
  final double valor;
  final String imagemPath;
  final int categoriaId;
  final int plataformaId;

  Produto({
    required this.id,
    required this.descricao,
    required this.link,
    required this.valor,
    required this.imagemPath,
    required this.categoriaId,
    required this.plataformaId,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'],
      descricao: json['descricao'],
      link: json['link'],
      valor: json['valor'],
      imagemPath: json['imagemPath'],
      categoriaId: json['categoriaId'],
      plataformaId: json['plataformaId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'link': link,
      'valor': valor,
      'imagemPath': imagemPath,
      'categoriaId': categoriaId,
      'plataformaId': plataformaId,
    };
  }
}