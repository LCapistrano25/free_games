class Ratings {
  final int id;
  final String title;
  final int count;
  final num percent;

  Ratings({
    required this.id,
    required this.title,
    required this.count,
    required this.percent,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      id: json['id'],
      title: json['title'],
      count: json['count'],
      percent: json['percent'].toDouble(),
    );
  }
}