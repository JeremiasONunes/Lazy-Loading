import 'package:flutter/material.dart';
import '../model/country.dart';
import '../services/country_service.dart';

/// Provider que gerencia o estado da lista de países e paginação
class CountryProvider with ChangeNotifier {
  /// Serviço que busca dados dos países (API, local, etc)
  CountryService _service = CountryService();

  /// Para permitir substituir o serviço em testes ou mocks
  void overrideService(CountryService service) {
    _service = service;
  }

  /// Lista completa dos países obtidos do serviço
  List<Country> _allCountries = [];

  /// Lista de países que estão sendo exibidos na UI (página atual)
  List<Country> _displayedCountries = [];

  /// Indica se está carregando dados
  bool _isLoading = false;

  /// Página atual para controle da paginação
  int _currentPage = 0;

  /// Quantidade de países por página
  static const int _pageSize = 10;

  /// Getter público para os países que serão exibidos
  List<Country> get countries => List.unmodifiable(_displayedCountries);

  /// Getter público para o estado de carregamento
  bool get isLoading => _isLoading;

  /// Carrega a primeira página de países
  Future<void> loadCountries() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      if (_allCountries.isEmpty) {
        _allCountries = await _service.fetchCountries();
        print('Total países carregados: ${_allCountries.length}');
      }
    } catch (e) {
      print('Erro ao carregar países: $e');
      _isLoading = false;
      notifyListeners();
      rethrow; // Opcional: você pode querer lançar a exceção para tratar no UI
      // ou só retornar para não quebrar o app
      // return;
    }

    _displayedCountries.clear();
    _currentPage = 0;

    await _loadNextPage();

    _isLoading = false;
    notifyListeners();
  }

  /// Carrega a próxima página de países (para paginação infinita)
  Future<void> loadMore() async {
    if (_isLoading) return;

    if (_displayedCountries.length >= _allCountries.length) return;

    _isLoading = true;
    notifyListeners();

    // Delay para simular carregamento (opcional)
    await Future.delayed(const Duration(milliseconds: 500));

    await _loadNextPage();

    _isLoading = false;
    notifyListeners();
  }

  /// Carrega uma página dos países (10 itens por padrão) e atualiza a lista exibida
  Future<void> _loadNextPage() async {
    final start = _currentPage * _pageSize;
    final end =
        (start + _pageSize) > _allCountries.length
            ? _allCountries.length
            : start + _pageSize;

    if (start >= _allCountries.length) return;

    _displayedCountries.addAll(_allCountries.sublist(start, end));
    _currentPage++;

    // Notificar somente nos métodos públicos para evitar múltiplas notificações
    // notifyListeners();
  }
}
