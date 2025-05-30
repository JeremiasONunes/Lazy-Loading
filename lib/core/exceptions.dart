// Define uma exceção personalizada chamada ApiException que implementa a interface Exception.
class ApiException implements Exception {
  // Mensagem de erro associada à exceção.
  final String message;

  // Construtor que recebe a mensagem de erro.
  ApiException(this.message);

  // Sobrescreve o método toString para exibir a mensagem de erro formatada.
  @override
  String toString() => 'ApiException: $message';
}
