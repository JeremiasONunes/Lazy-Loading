
# Lazy Loading Países - Flutter App

Este projeto é um aplicativo Flutter que exibe uma lista de países com suas respectivas bandeiras utilizando carregamento preguiçoso (*lazy loading*). A aplicação consome uma API pública para obter dados atualizados sobre os países, exibindo os itens em páginas de 10 elementos por vez, carregando mais países conforme o usuário rola a lista para baixo.

## Funcionalidades

- **Lista paginada (lazy loading):** exibe os países em blocos, carregando mais itens conforme o usuário chega próximo do final da lista.
- **Detalhes do país:** ao tocar em um país, abre uma tela com a bandeira e o nome do país.
- **Indicador de carregamento:** exibe spinner enquanto os dados estão sendo carregados.
- **Pull-to-refresh:** permite carregar mais países ao puxar a lista para baixo.
- **Gerenciamento de estado:** utiliza o `Provider` para controle eficiente dos dados e atualização da UI.
- **Tratamento de erros:** exibe ícones substitutos quando a imagem da bandeira não pode ser carregada.
- **Código comentado:** todos os arquivos possuem comentários para facilitar o entendimento do funcionamento do projeto.

## Estrutura do projeto

- `model/`: contém a classe `Country` para representar os dados do país.
- `provider/`: gerencia o estado e lógica de paginação dos países.
- `services/`: faz requisições HTTP para a API e converte os dados.
- `screens/`: telas do app (`CountryListScreen` para lista e `CountryDetailScreen` para detalhes).
- `widget/`: componentes reutilizáveis, como o item de país e o indicador de carregamento.
- `core/`: constantes do projeto, como cores e espaçamentos.

## Como usar

1. Clone este repositório:
   ```bash
   git clone <url-do-repositorio>
   ```
2. Navegue até a pasta do projeto:
   ```bash
   cd lazy_loading_paises_flutter
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Execute o app no emulador ou dispositivo conectado:
   ```bash
   flutter run
   ```

## Requisitos

- Flutter SDK instalado (versão estável recomendada)
- Conexão com a internet para carregar dados da API

## Tecnologias usadas

- Flutter & Dart
- Provider para gerenciamento de estado
- HTTP para requisições REST
- API pública de países (definida na constante `AppConstants.apiUrl`)

## Estrutura comentada

- Toda os codigos foram comentados para melhor entendimento dos codigos desenvolvidos.
---

**Autor:** Jeremias O Nunes
