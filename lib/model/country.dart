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

  // Países fronteiriços
  final List<String> borders;

  // País sem litoral?
  final bool landlocked;

  // Código telefônico internacional
  final String phoneCode;

  // Construtor principal
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

  /// Cria uma instância a partir de um JSON (vindo da API)
  factory Country.fromJson(Map<String, dynamic> json) {
    final currencies = json['currencies'] as Map<String, dynamic>?;
    final languages = json['languages'] as Map<String, dynamic>?;

    return Country(
      name: json['name']?['common'] ?? 'Desconhecido',
      flagUrl: json['flags']?['png'] ?? '',

      capital:
          (json['capital'] != null && (json['capital'] as List).isNotEmpty)
              ? json['capital'][0]
              : '',

      population: json['population'] ?? 0,
      area: (json['area'] != null) ? (json['area'] as num).toDouble() : 0.0,

      currencyName:
          (currencies != null && currencies.isNotEmpty)
              ? currencies.values.first['name'] ?? 'Desconhecida'
              : 'Desconhecida',

      currencySymbol:
          (currencies != null && currencies.isNotEmpty)
              ? currencies.values.first['symbol'] ?? ''
              : '',

      language:
          (languages != null && languages.isNotEmpty)
              ? languages.values.first
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

  /// Factory para retornar um país vazio (útil para retornos padrão)
  factory Country.vazio() {
    return Country(
      name: '',
      flagUrl: '',
      capital: '',
      population: 0,
      area: 0.0,
      currencyName: '',
      currencySymbol: '',
      language: '',
      borders: const [],
      landlocked: false,
      phoneCode: '',
    );
  }
}
