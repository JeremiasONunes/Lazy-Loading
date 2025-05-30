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

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .center, // Centraliza os widgets horizontalmente

          children: [
            // Exibe a bandeira do país a partir da URL
            Image.network(
              country.flagUrl,
              width: 200, // Largura fixa da imagem
              height: 120, // Altura fixa da imagem
              fit:
                  BoxFit.cover, // Ajusta a imagem para cobrir o espaço definido
              // Caso a imagem não carregue, exibe um ícone padrão de bandeira
              errorBuilder:
                  (_, __, ___) => const Icon(Icons.flag_outlined, size: 100),
            ),

            const SizedBox(height: 24), // Espaço vertical entre imagem e texto
            // Exibe o nome do país em destaque
            Text(
              country.name,
              style: TextStyle(
                color: AppConstants.primaryColor, // Cor primária
                fontSize: 28, // Tamanho grande da fonte
                fontWeight: FontWeight.bold, // Texto em negrito
              ),
            ),

            // Comentário indicando que pode-se adicionar mais informações do país aqui
            // como capital, população, região, etc, caso esses dados estejam disponíveis na API
          ],
        ),
      ),
    );
  }
}
