import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:app_lazy_loading/model/country.dart';
import 'package:app_lazy_loading/provider/country_provider.dart';
import 'package:app_lazy_loading/screens/country_list_screen.dart';
import 'package:app_lazy_loading/widget/country_item.dart';
import 'package:app_lazy_loading/screens/country_detail_screen.dart';

class FakeCountryProvider extends CountryProvider {
  late List<Country> _allCountries;
  late List<Country> _displayedCountries;

  FakeCountryProvider(List<Country> fakeCountries) {
    _allCountries = fakeCountries;
    _displayedCountries = fakeCountries;
  }

  @override
  Future<void> loadCountries() async {}

  @override
  Future<void> loadMore() async {}

  @override
  bool get isLoading => false;

  @override
  List<Country> get countries => _displayedCountries;
}

void main() {
  late FakeCountryProvider fakeProvider;

  final fakeCountries = [
    Country(
      name: 'Brasil',
      flagUrl: 'https://flagcdn.com/br.svg',
      capital: 'Brasília',
      population: 211000000,
      area: 8515767.0,
      currencyName: 'Real',
      currencySymbol: 'R\$',
      language: 'Portuguese',
      borders: ['Argentina', 'Bolivia'],
      landlocked: false,
      phoneCode: '+55',
    ),
  ];

  setUp(() {
    fakeProvider = FakeCountryProvider(fakeCountries);
  });

  Widget buildTestWidget() {
    return ChangeNotifierProvider<CountryProvider>.value(
      value: fakeProvider,
      child: const MaterialApp(home: CountryListScreen()),
    );
  }

  testWidgets('Cenário 01 – Verifica se o nome do país é carregado', (
    tester,
  ) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Brasil'), findsOneWidget);
    });
  });

  testWidgets('Cenário 02 – Verifica se ao clicar abre detalhes', (
    tester,
  ) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Brasil'));
      await tester.pumpAndSettle();

      expect(find.byType(CountryDetailScreen), findsOneWidget);
      expect(find.text('Brasil'), findsWidgets);
    });
  });

  testWidgets('Cenário 03 – Verifica se a bandeira é exibida', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final countryItem = find.byType(CountryItem);
      expect(countryItem, findsWidgets);

      final image = find.descendant(
        of: countryItem.first,
        matching: find.byType(Image),
      );
      expect(image, findsOneWidget);
    });
  });
}
