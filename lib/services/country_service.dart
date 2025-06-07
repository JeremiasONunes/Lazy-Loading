import 'dart:convert'; // Biblioteca para decodificar JSON
import 'package:http/http.dart'
    as http; // Biblioteca HTTP para fazer requisições web
import '../core/constants.dart'; // Importa constantes do projeto
import '../core/exceptions.dart'; // Importa classe de exceções personalizadas
import '../model/country.dart'; // Modelo Country para mapear dados recebidos

// Serviço responsável por buscar dados dos países na API externa
class CountryService {
  // Método que busca a lista de países da API e retorna uma lista de Country
  Future<List<Country>> fetchCountries() async {
    // Faz uma requisição HTTP GET para a URL definida nas constantes
    final response = await http.get(Uri.parse(AppConstants.apiUrl));

    // Se a requisição foi bem-sucedida (código 200)
    if (response.statusCode == 200) {
      // Decodifica o corpo da resposta (JSON) para uma lista dinâmica
      final List<dynamic> data = jsonDecode(response.body);

      // Converte cada item JSON em um objeto Country usando o método fromJson
      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      // Se o código não for 200, lança uma exceção personalizada com o código de erro
      throw ApiException('Erro ao carregar países: ${response.statusCode}');
    }
  }
}
