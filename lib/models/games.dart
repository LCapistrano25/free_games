import 'package:games/models/esrbratings.dart';
import 'package:games/models/genres.dart';
import 'package:games/models/plataforms.dart';
import 'package:games/models/ratings.dart';
import 'package:games/models/screenshot.dart';
import 'package:games/models/store.dart';
import 'package:games/models/tags.dart';

class Games {
  // Dados principais
  final int id;
  final String slug;
  final String name;
  final String? released;
  final bool tba;
  final String? backgroundImage;
  final String updated;
  final String? userGame;

  // Avaliações e métricas
  final num rating;
  final num ratingTop;
  final List<Ratings> ratings;
  final int ratingsCount;
  final int reviewsCount;
  final int reviewsTextCount;
  final int added;
  final Map<String, dynamic>? addedByStatus;
  final String? metacritic;
  final int playtime;
  final int suggestionsCount;

  // Objetos complexos
  final List<GamePlatform> platforms;
  final List<GameStore> stores;
  final List<Genre> genres;
  final List<Tag> tags;
  final List<Screenshot> screenshots;
  final EsrbRating? esrbRating;

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
    required this.platforms,
    required this.stores,
    required this.genres,
    required this.tags,
    required this.screenshots,
    required this.esrbRating,
  });

  factory Games.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Games(
        id: 0,
        slug: '',
        name: 'Desconhecido',
        released: null,
        tba: false,
        backgroundImage: null,
        updated: '',
        userGame: null,
        rating: 0,
        ratingTop: 0,
        ratings: [],
        ratingsCount: 0,
        reviewsCount: 0,
        reviewsTextCount: 0,
        added: 0,
        addedByStatus: {},
        metacritic: null,
        playtime: 0,
        suggestionsCount: 0,
        platforms: [],
        stores: [],
        genres: [],
        tags: [],
        screenshots: [],
        esrbRating: null,
      );
    }

    return Games(
      id: json['id'] ?? 0,
      slug: json['slug'] ?? '',
      name: json['name'] ?? 'Desconhecido',
      released: json['released'],
      tba: json['tba'] ?? false,
      backgroundImage: json['background_image'],
      updated: json['updated'] ?? '',
      userGame: json['user_game']?.toString(),
      rating: json['rating'] ?? 0,
      ratingTop: json['rating_top'] ?? 0,
      ratings: (json['ratings'] as List? ?? [])
          .map((i) => Ratings.fromJson(i))
          .toList(),
      ratingsCount: json['ratings_count'] ?? 0,
      reviewsCount: json['reviews_count'] ?? 0,
      reviewsTextCount: json['reviews_text_count'] ?? 0,
      added: json['added'] ?? 0,
      addedByStatus: json['added_by_status'] as Map<String, dynamic>?,
      metacritic: json['metacritic']?.toString(),
      playtime: json['playtime'] ?? 0,
      suggestionsCount: json['suggestions_count'] ?? 0,
      platforms: (json['platforms'] as List? ?? [])
          .map((p) => GamePlatform.fromJson(p))
          .toList(),
      stores: (json['stores'] as List? ?? [])
          .map((s) => GameStore.fromJson(s))
          .toList(),
      genres: (json['genres'] as List? ?? [])
          .map((g) => Genre.fromJson(g))
          .toList(),
      tags: (json['tags'] as List? ?? [])
          .map((t) => Tag.fromJson(t))
          .toList(),
      screenshots: (json['short_screenshots'] as List? ?? [])
          .map((s) => Screenshot.fromJson(s))
          .toList(),
      esrbRating: json['esrb_rating'] != null
          ? EsrbRating.fromJson(json['esrb_rating'])
          : null,
    );
  }
}
