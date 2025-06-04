import 'package:games/models/ratings.dart';

class Games {
  final int id;
  final String slug;
  final String name;
  final String? released;
  final bool tba;
  final String? backgroundImage;
  final num rating;
  final num ratingTop;
  final List<Ratings> ratings;
  final int ratingsCount;
  final int reviewsTextCount;
  final int added;
  final Map<String, dynamic>? addedByStatus;
  final String? metacritic;
  final int playtime;
  final int suggestionsCount;
  final String updated;
  final String? userGame;
  final int reviewsCount;

  Games({
    required this.id,
    required this.slug,
    required this.name,
    required this.released,
    required this.tba,
    required this.backgroundImage,
    required this.rating,
    required this.ratingTop,
    required this.ratings,
    required this.ratingsCount,
    required this.reviewsTextCount,
    required this.added,
    required this.addedByStatus,
    required this.metacritic,
    required this.playtime,
    required this.suggestionsCount,
    required this.updated,
    required this.userGame,
    required this.reviewsCount,
  });

  factory Games.fromJson(Map<String, dynamic> json) {
    var ratingsList = json['ratings'] as List? ?? [];
    List<Ratings> ratings = ratingsList.map((i) => Ratings.fromJson(i)).toList();

    return Games(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      name: json['name'] ?? '',
      released: json['released'],
      tba: json['tba'] ?? false,
      backgroundImage: json['background_image'],
      rating: json['rating'] ?? 0,
      ratingTop: json['rating_top'] ?? 0,
      ratings: ratings,
      ratingsCount: json['ratings_count'] ?? 0,
      reviewsTextCount: json['reviews_text_count'] ?? 0,
      added: json['added'] ?? 0,
      addedByStatus: json['added_by_status'],
      metacritic: json['metacritic']?.toString(),
      playtime: json['playtime'] ?? 0,
      suggestionsCount: json['suggestions_count'] ?? 0,
      updated: json['updated'] ?? '',
      userGame: json['user_game']?.toString(),
      reviewsCount: json['reviews_count'] ?? 0,
    );
  }
}
