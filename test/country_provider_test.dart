import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app_lazy_loading/provider/country_provider.dart';
import 'package:app_lazy_loading/model/country.dart';
import 'mocks/mock_country_service.mocks.dart';

void main() {
  late CountryProvider provider;
  late MockCountryService mockService;

  setUp(() {
    mockService = MockCountryService();
    provider = CountryProvider();
    provider.overrideService(mockService);
  });

  test('01 - Listagem com sucesso (Fluxo principal)', () async {
    final mockCountries = [
      Country(
        name: 'Brasil',
        flagUrl: 'https://flagcdn.com/br.png',
        capital: 'Brasília',
        population: 211000000,
        area: 8515767.0,
        currencyName: 'Real',
        currencySymbol: 'R\$',
        language: 'Portuguese',
        borders: ['Argentina', 'Paraguay'],
        landlocked: false,
        phoneCode: '+55',
      ),
    ];

    when(mockService.fetchCountries()).thenAnswer((_) async => mockCountries);

    await provider.loadCountries();

    expect(provider.countries.isNotEmpty, true);
    expect(provider.countries.first.name, equals('Brasil'));
    expect(provider.countries.first.flagUrl, contains('br.png'));
  });

  test('02 - Falha na listagem (Erro controlado)', () async {
    when(mockService.fetchCountries()).thenThrow(Exception('Erro na API'));

    expect(() async => await provider.loadCountries(), throwsException);
    expect(provider.isLoading, false);
  });

  test('03 - Buscar país específico com sucesso (Fluxo principal)', () async {
    final mockCountries = [
      Country(
        name: 'Brasil',
        flagUrl: 'https://flagcdn.com/br.png',
        capital: 'Brasília',
        population: 211000000,
        area: 8515767.0,
        currencyName: 'Real',
        currencySymbol: 'R\$',
        language: 'Portuguese',
        borders: ['Argentina', 'Paraguay'],
        landlocked: false,
        phoneCode: '+55',
      ),
      Country(
        name: 'Argentina',
        flagUrl: 'https://flagcdn.com/ar.png',
        capital: 'Buenos Aires',
        population: 45000000,
        area: 2780400.0,
        currencyName: 'Peso',
        currencySymbol: '\$',
        language: 'Spanish',
        borders: ['Brasil', 'Chile'],
        landlocked: false,
        phoneCode: '+54',
      ),
    ];

    when(mockService.fetchCountries()).thenAnswer((_) async => mockCountries);

    await provider.loadCountries();

    final brasil = provider.countries.firstWhere(
      (c) => c.name == 'Brasil',
      orElse: () => Country.vazio(),
    );

    expect(brasil.name, 'Brasil');
    expect(brasil.capital, 'Brasília');
  });

  test('04 - Buscar país que não existe (Fluxo alternativo)', () async {
    final mockCountries = [
      Country(
        name: 'Brasil',
        flagUrl: 'https://flagcdn.com/br.png',
        capital: 'Brasília',
        population: 211000000,
        area: 8515767.0,
        currencyName: 'Real',
        currencySymbol: 'R\$',
        language: 'Portuguese',
        borders: ['Argentina', 'Paraguay'],
        landlocked: false,
        phoneCode: '+55',
      ),
    ];

    when(mockService.fetchCountries()).thenAnswer((_) async => mockCountries);

    await provider.loadCountries();

    final inexistente = provider.countries.firstWhere(
      (c) => c.name == 'Japão',
      orElse: () => Country.vazio(),
    );

    expect(inexistente.name, '');
  });

  test(
    '05 - País com campos vazios (Dados incompletos: capital, bandeira)',
    () async {
      final mockCountries = [
        Country(
          name: 'Chile',
          flagUrl: '',
          capital: '',
          population: 0,
          area: 0,
          currencyName: '',
          currencySymbol: '',
          language: '',
          borders: const [],
          landlocked: false,
          phoneCode: '',
        ),
      ];

      when(mockService.fetchCountries()).thenAnswer((_) async => mockCountries);

      await provider.loadCountries();

      final chile = provider.countries.firstWhere(
        (c) => c.name == 'Chile',
        orElse: () => Country.vazio(),
      );

      expect(chile.capital, '');
      expect(chile.flagUrl, '');
    },
  );

  test(
    '06 - Verificar se a função listarPaises() foi chamada (Interação/método)',
    () async {
      final mockCountries = [
        Country(
          name: 'Brasil',
          flagUrl: 'https://flagcdn.com/br.png',
          capital: 'Brasília',
          population: 211000000,
          area: 8515767.0,
          currencyName: 'Real',
          currencySymbol: 'R\$',
          language: 'Portuguese',
          borders: ['Argentina', 'Paraguay'],
          landlocked: false,
          phoneCode: '+55',
        ),
      ];

      when(mockService.fetchCountries()).thenAnswer((_) async => mockCountries);

      await provider.loadCountries();

      verify(mockService.fetchCountries()).called(1);
    },
  );
}
