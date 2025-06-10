
class EsrbRating {
  final int id;
  final String name;

  EsrbRating({required this.id, required this.name});

  factory EsrbRating.fromJson(Map<String, dynamic> json) {
    return EsrbRating(
      id: json['id'],
      name: json['name'],
    );
  }
}
