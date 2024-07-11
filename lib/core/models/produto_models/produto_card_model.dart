class ProdutoCard {
  final int produtoId;
  final String link;
  final String descricao;
  final double valor;
  final String imagemPath;
  final bool isFavoritado;

  ProdutoCard({
    required this.produtoId,
    required this.link,
    required this.descricao,
    required this.valor,
    required this.imagemPath,
    required this.isFavoritado,
  });

  factory ProdutoCard.fromJson(Map<String, dynamic> json) {
    return ProdutoCard(
      produtoId: json['produtoId'],
      link: json['link'],
      descricao: json['descricao'],
      valor: json['valor'],
      imagemPath: json['imagemPath'],
      isFavoritado: json['isFavoritado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'produtoId': produtoId,
      'link': link,
      'descricao': descricao,
      'valor': valor,
      'imagemPath': imagemPath,
      'isFavoritado': isFavoritado,
    };
  }
}