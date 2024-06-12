class Produto {
  String nome;
  double preco;
  String categoria;
  String link;
  String plataforma;

  Produto({
    required this.nome,
    required this.preco,
    required this.categoria,
    this.link = '',
    this.plataforma = '',
  });
}