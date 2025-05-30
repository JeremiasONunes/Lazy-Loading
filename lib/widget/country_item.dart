import 'package:flutter/material.dart'; // Importa widgets básicos do Flutter
import '../core/constants.dart'; // Importa constantes do projeto (cores, espaçamentos)
import '../model/country.dart'; // Importa o modelo Country

// Widget que representa um item na lista de países
class CountryItem extends StatelessWidget {
  // Objeto Country com dados do país a ser exibido
  final Country country;

  // Função callback que será chamada ao tocar no item
  final VoidCallback onTap;

  // Construtor com parâmetros obrigatórios para country e onTap
  const CountryItem({super.key, required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Espaçamento interno horizontal e vertical do item
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 8,
      ),

      // Ícone/bandeira à esquerda (leading) - imagem carregada da URL da bandeira
      leading: Image.network(
        country.flagUrl,
        width: 50, // Largura da imagem
        height: 30, // Altura da imagem
        fit: BoxFit.cover, // Ajusta a imagem para cobrir a área definida
        // Caso a imagem não carregue, exibe um ícone padrão de bandeira
        errorBuilder: (_, __, ___) => const Icon(Icons.flag_outlined),
      ),

      // Título do item - nome do país com estilo personalizado
      title: Text(
        country.name,
        style: TextStyle(
          color:
              AppConstants.primaryColor, // Cor primária definida nas constantes
          fontWeight: FontWeight.w600, // Peso da fonte semi-negrito
          fontSize: 16, // Tamanho da fonte
        ),
      ),

      // Ícone à direita (trailing) indicando que é possível navegar
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),

      // Ação executada quando o item é tocado
      onTap: onTap,
    );
  }
}
