import 'package:games/models/geral.dart';
import 'package:games/models/games.dart';
import 'package:games/utils/service.dart';

class GamesServices {
  static Future<List<dynamic>> fetchData(String key, {int pageSize = 10, String search = ''}) async {
    await Future.delayed(const Duration(seconds: 5)); // Simulate network delay

    final url = "https://api.rawg.io/api/games?key=$key&page_size=$pageSize&search=$search";

    final response = await ApiService.request(
      url: url,
      verb: HttpVerb.get,
      fromJson: (json) {
        final geral = Geral.fromJson(json);
        return geral.results.map((e) => Games.fromJson(e)).toList();
      },
    );

    return [response.data ?? [], response.statusCode];
  }
}
