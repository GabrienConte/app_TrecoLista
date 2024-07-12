class ProdutoUpdateDto {
  final int categoriaId;
  final int plataformaId;
  final int prioridade;
  final bool isAvisado;

  ProdutoUpdateDto({
    required this.categoriaId,
    required this.plataformaId,
    required this.prioridade,
    required this.isAvisado,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoriaId': categoriaId,
      'plataformaId': plataformaId,
      'prioridade': prioridade,
      'isAvisado': isAvisado,
    };
  }
}
