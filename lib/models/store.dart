class StoreInfo {
  final int id;
  final String name;
  final String slug;

  StoreInfo({required this.id, required this.name, required this.slug});

  factory StoreInfo.fromJson(Map<String, dynamic> json) {
    return StoreInfo(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class GameStore {
  final int id;
  final StoreInfo store;

  GameStore({required this.id, required this.store});

  factory GameStore.fromJson(Map<String, dynamic> json) {
    return GameStore(
      id: json['id'],
      store: StoreInfo.fromJson(json['store']),
    );
  }
}
