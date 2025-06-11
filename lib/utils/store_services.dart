import 'package:games/models/geral.dart';
import 'package:games/models/store_details.dart';
import 'package:games/utils/service.dart';

class StoreServices {
  static Future<List<dynamic>> fetchStores(
    String key, {
    int pageSize = 20,
    int page = 1,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula delay de rede

    final url = "https://api.rawg.io/api/stores?key=$key&page_size=$pageSize&page=$page";

    final response = await ApiService.request(
      url: url,
      verb: HttpVerb.get,
      fromJson: (json) => json, // Retorna JSON puro
    );

    final geral = Geral.fromJson(response.data);
    final data = geral.results.map((e) => StoreModel.fromJson(e)).toList();

    return [
      data,               // Lista de lojas convertida
      response.statusCode,
      geral.count,        // Total de lojas
    ];
  }
}
