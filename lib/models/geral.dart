class Geral {
  final int count;
  final String next;
  final String previus;
  final List results;

  Geral({
      required this.count,
      required this.next,
      required this.previus,
      required this.results
    }
  );

  factory Geral.fromJson(Map<String, dynamic> json){
    return Geral(
      count: json['count'] ?? 0,
      next: json['next'] ?? '',
      previus: json['previus'] ?? '',
      results: json['results']
    );
  }
}