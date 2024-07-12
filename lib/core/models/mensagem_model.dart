class Mensagem {
  final String title;
  final String body;

  Mensagem({required this.title, required this.body});

  Map<String, dynamic> toJson() => {
    'title': title,
    'body': body,
  };

  factory Mensagem.fromJson(Map<String, dynamic> json) {
    return Mensagem(
      title: json['notification']['title'],
      body: json['notification']['body'],
    );
  }
}