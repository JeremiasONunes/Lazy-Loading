// Classe que representa um país com nome e URL da bandeira
class Country {
  // Nome do país (ex: "Brasil")
  final String name;

  // URL da imagem da bandeira do país
  final String flagUrl;

  // Construtor que exige os dois parâmetros obrigatórios
  Country({required this.name, required this.flagUrl});

  // Factory constructor para criar um objeto Country a partir de um Map JSON
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      // Acessa o nome comum do país no JSON, se não existir usa "Desconhecido"
      name: json['name']['common'] ?? 'Desconhecido',

      // Acessa o URL da bandeira em formato PNG, se não existir usa string vazia
      flagUrl: json['flags']['png'] ?? '', // também pode usar 'svg' se preferir
    );
  }
}
