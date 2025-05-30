import 'package:flutter/material.dart'; // Importa widgets básicos do Flutter
import 'package:provider/provider.dart'; // Importa o Provider para gerenciamento de estado

import 'core/constants.dart'; // Importa constantes do projeto (cores, etc)
import 'provider/country_provider.dart'; // Importa o CountryProvider (estado dos países)
import 'screens/country_list_screen.dart'; // Importa a tela principal da lista de países

// Função principal que inicia o app Flutter
void main() {
  runApp(const MyApp());
}

// Widget raiz do app, que configura o provider e o tema do MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Cria e disponibiliza o CountryProvider para toda a árvore de widgets
      create: (_) => CountryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Remove a faixa de debug no app
        title: 'Lazy Loading Países', // Título do app (usado no Android/iOS)
        // Configuração do tema visual do app
        theme: ThemeData(
          primaryColor:
              AppConstants.primaryColor, // Cor primária do app (constante)
          scaffoldBackgroundColor:
              Colors.white, // Fundo padrão branco para telas

          appBarTheme: AppBarTheme(
            backgroundColor:
                AppConstants.primaryColor, // Cor de fundo da AppBar
            foregroundColor: Colors.white, // Cor dos textos e ícones na AppBar
            elevation: 0, // Remover sombra da AppBar
          ),

          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary:
                AppConstants
                    .primaryColor, // Cor secundária para botões, destaques
          ),

          // Definição da cor padrão do texto do corpo das telas
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
          ),
        ),

        // Tela inicial do app: lista de países
        home: const CountryListScreen(),
      ),
    );
  }
}
