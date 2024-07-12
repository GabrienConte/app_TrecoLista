class ProdutoCreateDto {
  final String link;
  final String descricao;
  final String valor;
  final String? imagemPath;
  final int categoriaId;
  final int plataformaId;
  final int prioridade;
  final bool isAvisado;

  ProdutoCreateDto({
    required this.link,
    required this.descricao,
    required this.valor,
    this.imagemPath,
    required this.categoriaId,
    required this.plataformaId,
    required this.prioridade,
    required this.isAvisado,
  });

  Map<String, dynamic> toJson() {
    return {
      'link': link,
      'descricao': descricao,
      'valor': valor,
      'imagemPath': imagemPath,
      'categoriaId': categoriaId,
      'plataformaId': plataformaId,
      'prioridade': prioridade,
      'isAvisado': isAvisado,
    };
  }
}
