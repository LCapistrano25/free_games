class StoreInfo {
  final int id;
  final String name;
  final String slug;

  StoreInfo({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory StoreInfo.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return StoreInfo(id: 0, name: 'Desconhecido', slug: '');
    }

    return StoreInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Desconhecido',
      slug: json['slug'] ?? '',
    );
  }
}

class GameStore {
  final int id;
  final StoreInfo store;

  GameStore({
    required this.id,
    required this.store,
  });

  factory GameStore.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return GameStore(id: 0, store: StoreInfo.fromJson(null));
    }

    return GameStore(
      id: json['id'] ?? 0,
      store: StoreInfo.fromJson(json['store']),
    );
  }
}
