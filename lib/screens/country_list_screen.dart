import 'package:flutter/material.dart'; // Importa widgets básicos do Flutter
import 'package:provider/provider.dart'; // Importa o Provider para gerenciamento de estado

import '../core/constants.dart'; // Constantes do projeto (cores, espaçamentos, etc)
import '../model/country.dart'; // Modelo Country
import '../provider/country_provider.dart'; // Provider que gerencia lista de países e paginação
import '../widget/country_item.dart'; // Widget para exibir item da lista de países
import '../widget/loading_indicator.dart'; // Widget para exibir indicador de carregamento
import 'country_detail_screen.dart'; // Tela de detalhes do país

// Tela principal que lista países com paginação e refresh
class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  // Controlador para detectar scroll na lista
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Obtém o provider para carregar os países iniciais
    final provider = context.read<CountryProvider>();
    provider.loadCountries();

    // Adiciona listener para detectar quando usuário chegou perto do fim da lista
    _scrollController.addListener(() {
      // Se o scroll estiver a 120 pixels do fim da lista, carrega mais países
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 120) {
        provider.loadMore();
      }
    });
  }

  @override
  void dispose() {
    // Remove o controlador para evitar vazamentos de memória
    _scrollController.dispose();
    super.dispose();
  }

  // Abre a tela de detalhes do país selecionado
  void _openCountryDetail(Country country) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CountryDetailScreen(country: country)),
    );
  }

  // Função que trata o pull-to-refresh para carregar mais países
  Future<void> _handleRefresh() async {
    final provider = context.read<CountryProvider>();
    provider.loadMore(); // Ao puxar para baixo, carrega mais 10 países
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Países'), // Título da tela
        backgroundColor:
            AppConstants.primaryColor, // Cor do appbar conforme constante
      ),
      body: Consumer<CountryProvider>(
        // Observa mudanças no provider
        builder: (_, provider, __) {
          final countries =
              provider.countries; // Lista atual de países exibidos
          final isLoading = provider.isLoading; // Flag de carregamento

          // Enquanto estiver carregando e sem dados, exibe indicador de loading centralizado
          if (countries.isEmpty && isLoading) {
            return const LoadingIndicator();
          }

          return RefreshIndicator(
            onRefresh:
                _handleRefresh, // Função executada ao puxar para atualizar
            child: ListView.builder(
              controller: _scrollController, // Controlador para detectar scroll
              itemCount: countries.length, // Quantidade de itens na lista
              itemBuilder: (_, index) {
                final country = countries[index];
                return CountryItem(
                  country: country,
                  onTap:
                      () => _openCountryDetail(
                        country,
                      ), // Abre detalhes ao tocar no item
                );
              },
            ),
          );
        },
      ),
    );
  }
}
