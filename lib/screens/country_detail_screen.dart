import 'package:flutter/material.dart'; // Importa os widgets básicos do Flutter
import '../core/constants.dart'; // Importa constantes do projeto (ex: cores, espaçamentos)
import '../model/country.dart'; // Importa a classe Country (modelo)

// Tela que exibe os detalhes de um país específico
class CountryDetailScreen extends StatelessWidget {
  // Objeto Country que contém os dados a serem exibidos
  final Country country;

  // Construtor com parâmetro obrigatório country e key opcional
  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior da tela com título e cor de fundo
      appBar: AppBar(
        title: Text(country.name), // Mostra o nome do país como título
        backgroundColor:
            AppConstants
                .primaryColor, // Usa a cor primária definida nas constantes
      ),

      // Corpo da tela com conteúdo principal
      body: Padding(
        padding: const EdgeInsets.all(
          AppConstants.defaultPadding,
        ), // Espaçamento interno geral
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .center, // Centraliza os widgets horizontalmente
            children: [
              // Bandeira
              Image.network(
                country.flagUrl,
                width: 200,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => const Icon(Icons.flag_outlined, size: 100),
              ),

              const SizedBox(height: 24),

              // Nome do país
              Text(
                country.name,
                style: TextStyle(
                  color: AppConstants.primaryColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // Informações detalhadas em lista
              InfoRow(
                icon: Icons.location_city,
                label: 'Capital',
                value: country.capital,
              ),
              InfoRow(
                icon: Icons.people,
                label: 'População',
                value: country.population.toString(),
              ),
              InfoRow(
                icon: Icons.map,
                label: 'Área (km²)',
                value: country.area.toStringAsFixed(0),
              ),
              InfoRow(
                icon: Icons.monetization_on,
                label: 'Moeda',
                value: '${country.currencyName} (${country.currencySymbol})',
              ),
              InfoRow(
                icon: Icons.language,
                label: 'Idioma oficial',
                value: country.language,
              ),
              InfoRow(
                icon: Icons.border_all,
                label: 'Fronteiras',
                value:
                    country.borders.isNotEmpty
                        ? country.borders.join(', ')
                        : 'Nenhuma',
              ),
              InfoRow(
                icon: Icons.no_drinks,
                label: 'Sem litoral',
                value: country.landlocked ? 'Sim' : 'Não',
              ),
              InfoRow(
                icon: Icons.phone,
                label: 'Código telefônico',
                value: country.phoneCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget auxiliar para exibir uma linha de informação com ícone, label e valor
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: AppConstants.primaryColor),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
