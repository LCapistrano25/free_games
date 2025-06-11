class StoreGame {
  final int id;
  final String slug;
  final String name;
  final int added;

  StoreGame({
    required this.id,
    required this.slug,
    required this.name,
    required this.added,
  });

  factory StoreGame.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return StoreGame(id: 0, slug: '', name: 'Desconhecido', added: 0);
    }

    return StoreGame(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      name: json['name'] ?? 'Desconhecido',
      added: json['added'] ?? 0,
    );
  }
}

class StoreModel {
  final int id;
  final String name;
  final String slug;
  final String? domain;
  final int gamesCount;
  final String? imageBackground;
  final List<StoreGame> games;

  StoreModel({
    required this.id,
    required this.name,
    required this.slug,
    this.domain,
    required this.gamesCount,
    this.imageBackground,
    required this.games,
  });

  factory StoreModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return StoreModel(
        id: 0,
        name: 'Desconhecido',
        slug: '',
        domain: null,
        gamesCount: 0,
        imageBackground: null,
        games: [],
      );
    }

    return StoreModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Desconhecido',
      slug: json['slug'] ?? '',
      domain: json['domain'],
      gamesCount: json['games_count'] ?? 0,
      imageBackground: json['image_background'],
      games: (json['games'] as List? ?? [])
          .map((game) => StoreGame.fromJson(game))
          .toList(),
    );
  }
}
