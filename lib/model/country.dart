class Country {
  // Nome do país (ex: "Brasil")
  final String name;

  // URL da imagem da bandeira do país
  final String flagUrl;

  // Capital do país
  final String capital;

  // População
  final int population;

  // Área em km²
  final double area;

  // Moeda (nome e símbolo)
  final String currencyName;
  final String currencySymbol;

  // Idioma oficial
  final String language;

  // Países fronteiriços (lista de códigos)
  final List<String> borders;

  // Se é país sem litoral
  final bool landlocked;

  // Código telefônico internacional
  final String phoneCode;

  // Construtor que exige os parâmetros obrigatórios
  Country({
    required this.name,
    required this.flagUrl,
    required this.capital,
    required this.population,
    required this.area,
    required this.currencyName,
    required this.currencySymbol,
    required this.language,
    required this.borders,
    required this.landlocked,
    required this.phoneCode,
  });

  // Factory constructor para criar um objeto Country a partir de um Map JSON
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'Desconhecido',
      flagUrl: json['flags']['png'] ?? '',

      capital:
          (json['capital'] != null && (json['capital'] as List).isNotEmpty)
              ? json['capital'][0]
              : 'Desconhecida',

      population: json['population'] ?? 0,
      area: (json['area'] != null) ? (json['area'] as num).toDouble() : 0.0,

      currencyName:
          (json['currencies'] != null && json['currencies'].isNotEmpty)
              ? json['currencies'].values.first['name'] ?? 'Desconhecida'
              : 'Desconhecida',

      currencySymbol:
          (json['currencies'] != null && json['currencies'].isNotEmpty)
              ? json['currencies'].values.first['symbol'] ?? ''
              : '',

      language:
          (json['languages'] != null && json['languages'].isNotEmpty)
              ? json['languages'].values.first
              : 'Desconhecido',

      borders:
          (json['borders'] != null) ? List<String>.from(json['borders']) : [],

      landlocked: json['landlocked'] ?? false,

      phoneCode:
          (json['idd'] != null &&
                  json['idd']['root'] != null &&
                  json['idd']['suffixes'] != null &&
                  (json['idd']['suffixes'] as List).isNotEmpty)
              ? '${json['idd']['root']}${json['idd']['suffixes'][0]}'
              : '',
    );
  }
}
