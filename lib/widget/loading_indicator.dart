import 'package:flutter/material.dart'; // Importa widgets básicos do Flutter
import '../core/constants.dart'; // Importa constantes do projeto (cores, espaçamentos)

// Widget que exibe um indicador de carregamento (loading spinner)
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Espaçamento interno ao redor do indicador, usando valor definido nas constantes
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Center(
        // Centraliza o indicador na tela ou no espaço disponível
        child: CircularProgressIndicator(
          color:
              AppConstants
                  .primaryColor, // Cor do spinner conforme constante primária
          strokeWidth: 3, // Espessura da borda do spinner
        ),
      ),
    );
  }
}
