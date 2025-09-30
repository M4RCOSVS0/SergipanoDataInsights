import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/time.dart';

class TimeService {
  Future<List<Time>> getTimes({int? minTitulos}) async {
    // Obtém a URL base do arquivo .env ou usa o valor padrão
    final baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:5048';
    final endpoint = '/api/Clubes';

    // Constrói a URL com parâmetros opcionais
    String url = baseUrl + endpoint;
    if (minTitulos != null) {
      url += '?minTitulos=$minTitulos';
    }

    // Faz a requisição HTTP GET
    final response = await http.get(Uri.parse(url));

    // Processa a resposta
    if (response.statusCode == 200) {
      // Converte JSON em lista de objetos Time
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Time.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar os times');
    }
  }
}