import 'package:games/models/platforms_details.dart';
import 'package:games/utils/service.dart';

class PlatformServices {
  static Future<List<dynamic>> fetchPlatforms(String key, {int pageSize = 20, int page = 1}) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    final url = "https://api.rawg.io/api/platforms?key=$key&page_size=$pageSize&page=$page";

    final response = await ApiService.request(
      url: url,
      verb: HttpVerb.get,
      fromJson: (json) {
        final results = json['results'] as List? ?? [];
        return results.map((e) => PlatformModel.fromJson(e)).toList();
      },
    );

    print(response.data);
    print(response.statusCode);

    return [
      response.data ?? [],
      response.statusCode,
    ];
  }
}
