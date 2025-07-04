class PlatformInfo {
  final int id;
  final String name;
  final String slug;

  PlatformInfo({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory PlatformInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return PlatformInfo(id: 0, name: 'Desconhecido', slug: '');
    }

    return PlatformInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Desconhecido',
      slug: json['slug'] ?? '',
    );
  }
}

class Requirements {
  final String? minimum;
  final String? recommended;

  Requirements({
    this.minimum,
    this.recommended,
  });

  factory Requirements.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Requirements();
    return Requirements(
      minimum: json['minimum'],
      recommended: json['recommended'],
    );
  }
}

class GamePlatform {
  final PlatformInfo platform;
  final String? releasedAt;
  final Requirements requirements;

  GamePlatform({
    required this.platform,
    this.releasedAt,
    required this.requirements,
  });

  factory GamePlatform.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return GamePlatform(
        platform: PlatformInfo(id: 0, name: 'Desconhecido', slug: ''),
        releasedAt: null,
        requirements: Requirements(),
      );
    }

    return GamePlatform(
      platform: PlatformInfo.fromJson(json['platform']),
      releasedAt: json['released_at'],
      requirements: Requirements.fromJson(json['requirements_en']),
    );
  }
}
