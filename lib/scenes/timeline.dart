import 'package:flutter/material.dart';
import 'package:games/models/games.dart';
import 'package:games/screens/error_screen.dart';
import 'package:games/screens/loading_screen.dart';
import 'package:games/screens/timeline_screen.dart';
import 'package:games/utils/games_services.dart';

class TimelineScene extends StatefulWidget {
  @override
  _TimelineSceneState createState() => _TimelineSceneState();
}

class _TimelineSceneState extends State<TimelineScene> {
  final String? apiKey = 'aa70995cc7274ac099fb0dce4eb4f1e7';
  final ScrollController _scrollController = ScrollController();

  int statusCode = 0;
  int currentPage = 1;
  bool isLoading = false;
  bool isLoadingMore = false;
  String searchQuery = '';
  List<Games> games = [];

  @override
  void initState() {
    super.initState();
    _fetchGames();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !isLoadingMore) {
      _loadMoreGames();
    }
  }

  Future<void> _fetchGames({String query = '', int page = 1}) async {
    final isNewSearch = page == 1;

    setState(() {
      if (isNewSearch) {
        isLoading = true;
        currentPage = 1;
        searchQuery = query;
      } else {
        isLoadingMore = true;
      }
    });

    try {
      final response = await GamesServices.fetchData(apiKey!, pageSize: 20, query: query, page: page);
      final int code = (response.length > 1 && response[1] is int) ? response[1] as int : 500;

      setState(() {
        statusCode = code;
        if (code == 200) {
          final newGames = response[0] as List<Games>;
          if (isNewSearch) {
            games = newGames;
          } else {
            games.addAll(newGames);
            currentPage = page;
          }
        } else {
          games = [];
        }
      });
    } catch (e) {
      debugPrint('Erro ao buscar jogos: $e');
      setState(() {
        games = [];
        statusCode = 500;
      });
    } finally {
      setState(() {
        isLoading = false;
        isLoadingMore = false;
      });
    }
  }

  void _searchGames(String query) => _fetchGames(query: query, page: 1);
  void _loadMoreGames() => _fetchGames(query: searchQuery, page: currentPage + 1);

  @override
  Widget build(BuildContext context) {
    if (statusCode == 0) return LoadingScreen();

    if (statusCode == 200) {
      return TimelineScreen(
        games: games,
        onRefresh: () => _fetchGames(query: searchQuery, page: 1),
        onSearch: _searchGames,
        isLoading: isLoading,
        isLoadingMore: isLoadingMore,
        searchQuery: searchQuery,
        scrollController: _scrollController,
      );
    }

    return ErrorScreen(
      message: 'Erro ao buscar jogos: $statusCode',
      onRefresh: () => _fetchGames(query: searchQuery, page: 1),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
