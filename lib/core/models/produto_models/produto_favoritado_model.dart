class ProdutoFavoritado {
  final int id;
  final String descricao;
  final String link;
  final double valor;
  final String imagemPath;
  final int categoriaId;
  final int plataformaId;
  final int prioridade;
  final bool aviso;

  ProdutoFavoritado({
    required this.id,
    required this.descricao,
    required this.link,
    required this.valor,
    required this.imagemPath,
    required this.categoriaId,
    required this.plataformaId,
    required this.prioridade,
    required this.aviso,
  });

  factory ProdutoFavoritado.fromJson(Map<String, dynamic> json) {
    return ProdutoFavoritado(
      id: json['id'],
      descricao: json['descricao'],
      link: json['link'],
      valor: json['valor'],
      imagemPath: json['imagemPath'],
      categoriaId: json['categoriaId'],
      plataformaId: json['plataformaId'],
      prioridade: json['prioridade'],
      aviso: json['aviso'],
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
      'prioridade': prioridade,
      'aviso': aviso,
    };
  }
}