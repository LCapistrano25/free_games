class PlatformGame {
  final int id;
  final String slug;
  final String name;
  final int added;

  PlatformGame({
    required this.id,
    required this.slug,
    required this.name,
    required this.added,
  });

  factory PlatformGame.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PlatformGame(id: 0, slug: '', name: 'Desconhecido', added: 0);
    }

    return PlatformGame(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      name: json['name'] ?? 'Desconhecido',
      added: json['added'] ?? 0,
    );
  }
}

class PlatformModel {
  final int id;
  final String name;
  final String slug;
  final int gamesCount;
  final String imageBackground;
  final String? image;
  final int? yearStart;
  final int? yearEnd;
  final List<PlatformGame> games;

  PlatformModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.gamesCount,
    required this.imageBackground,
    this.image,
    this.yearStart,
    this.yearEnd,
    required this.games,
  });

  factory PlatformModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PlatformModel(
        id: 0,
        name: 'Desconhecido',
        slug: '',
        gamesCount: 0,
        imageBackground: '',
        image: null,
        yearStart: null,
        yearEnd: null,
        games: [],
      );
    }

    return PlatformModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Desconhecido',
      slug: json['slug'] ?? '',
      gamesCount: json['games_count'] ?? 0,
      imageBackground: json['image_background'] ?? '',
      image: json['image'],
      yearStart: json['year_start'],
      yearEnd: json['year_end'],
      games: (json['games'] as List? ?? [])
          .map((g) => PlatformGame.fromJson(g))
          .toList(),
    );
  }
}
