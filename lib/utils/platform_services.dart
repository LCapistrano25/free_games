import 'package:games/models/platforms_details.dart';
import 'package:games/utils/service.dart';

class PlatformServices {
  static Future<List<dynamic>> fetchPlatforms(
    String key, {
    int pageSize = 20,
    int page = 1,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula delay de rede

    final url = "https://api.rawg.io/api/platforms?key=$key&page_size=$pageSize&page=$page";

    final response = await ApiService.request(
      url: url,
      verb: HttpVerb.get,
      fromJson: (json) => json, // Retorna JSON completo
    );

    final results = response.data['results'] as List? ?? [];
    final data = results.map((e) => PlatformModel.fromJson(e)).toList();
    final int count = response.data['count'] ?? 0;

    return [
      data,               // Lista de plataformas
      response.statusCode,
      count               // Total de plataformas disponíveis
    ];
  }
}
