class DispositivoToken {
  final int usuarioId;
  final String token;

  DispositivoToken({required this.usuarioId, required this.token});

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      'token': token,
    };
  }
}
