import 'package:flutter/material.dart'; // Importa pacotes do Flutter para UI e gerenciamento de estado
import '../model/country.dart'; // Importa a classe Country (modelo)
import '../services/country_service.dart'; // Importa serviço responsável por buscar dados dos países

// Provider que gerencia o estado da lista de países e sua paginação
class CountryProvider with ChangeNotifier {
  // Instância do serviço que busca os países (ex: API)
  final CountryService _countryService = CountryService();

  // Lista completa de países obtidos do serviço
  List<Country> _allCountries = [];

  // Lista de países que estão sendo exibidos na interface (pagina atual)
  List<Country> _displayedCountries = [];

  // Flag que indica se está carregando dados
  bool _isLoading = false;

  // Getter público para acessar os países atualmente exibidos
  List<Country> get countries => _displayedCountries;

  // Getter público para acessar o estado de carregamento
  bool get isLoading => _isLoading;

  // Controla a página atual para paginação
  int _currentPage = 0;

  // Define quantos países serão exibidos por página
  static const int _pageSize = 10;

  // Método para carregar os países iniciais (primeira página)
  Future<void> loadCountries() async {
    // Se já estiver carregando, não faz nada para evitar chamadas duplicadas
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners(); // Notifica UI para exibir loading

    // Se a lista completa estiver vazia, busca os países do serviço
    if (_allCountries.isEmpty) {
      _allCountries = await _countryService.fetchCountries();
    }

    // Limpa a lista de países exibidos (página atual)
    _displayedCountries.clear();

    // Reseta a página atual para a primeira
    _currentPage = 0;

    // Carrega a próxima página de países (no caso, a primeira)
    _loadNextPage();

    _isLoading = false;
    notifyListeners(); // Notifica UI para atualizar lista e esconder loading
  }

  // Método para carregar mais países (próxima página)
  Future<void> loadMore() async {
    // Evita múltiplos carregamentos simultâneos
    if (_isLoading) return;

    // Se já exibiu todos os países, não tenta carregar mais
    if (_displayedCountries.length >= _allCountries.length) return;

    _isLoading = true;
    notifyListeners(); // Notifica UI para exibir loading

    // Simula um delay para efeito de carregamento (pode remover se quiser)
    await Future.delayed(const Duration(milliseconds: 500));

    // Carrega a próxima página
    _loadNextPage();

    _isLoading = false;
    notifyListeners(); // Notifica UI para atualizar lista e esconder loading
  }

  // Método privado que adiciona uma página de países à lista exibida
  void _loadNextPage() {
    // Calcula o índice inicial da sublista para a página atual
    final int start = _currentPage * _pageSize;

    // Calcula o índice final da sublista, garantindo que não ultrapasse o tamanho da lista total
    final int end =
        (start + _pageSize) > _allCountries.length
            ? _allCountries.length
            : start + _pageSize;

    // Se o índice inicial já ultrapassou o total, não faz nada (não há mais páginas)
    if (start >= _allCountries.length) return;

    // Adiciona a sublista de países da página atual à lista exibida
    _displayedCountries.addAll(_allCountries.sublist(start, end));

    // Incrementa o contador da página atual para a próxima chamada
    _currentPage++;
  }
}
