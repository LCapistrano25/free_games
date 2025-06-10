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
  int statusCode = 0;
  int currentPage = 1;
  bool isLoading = false;
  bool isLoadingMore = false;
  List<Games> games = [];
  String searchQuery = '';
  final ScrollController _scrollController = ScrollController();
  final String? apiKey = 'aa70995cc7274ac099fb0dce4eb4f1e7';

  @override
  void initState() {
    super.initState();
    fetchGames();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !isLoadingMore) {
      loadMoreGames();
    }
  }

  void fetchGames() async {
    setState(() {
      isLoading = true;
      currentPage = 1;
    });

    try {
      var response = await GamesServices.fetchData(apiKey!, pageSize: 20, page: 1);
      setState(() {
        games = response[0] as List<Games>;
        statusCode = (response.length > 1 && response[1] is int) ? response[1] as int : 500;
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
      });
    }
  }

  void searchGames(String query) async {
    setState(() {
      isLoading = true;
      searchQuery = query;
      currentPage = 1;
    });

    try {
      var response = await GamesServices.fetchData(apiKey!, pageSize: 20, query: query, page: 1);
      setState(() {
        games = response[0] as List<Games>;
        statusCode = (response.length > 1 && response[1] is int) ? response[1] as int : 500;
      });
    } catch (e) {
      debugPrint('Erro na busca: $e');
      setState(() {
        games = [];
        statusCode = 500;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadMoreGames() async {
    setState(() {
      isLoadingMore = true;
    });

    int nextPage = currentPage + 1;

    try {
      var response = await GamesServices.fetchData(
        apiKey!,
        pageSize: 20,
        query: searchQuery,
        page: nextPage,
      );

      final int responseCode = (response.length > 1 && response[1] is int) ? response[1] as int : 500;

      if (responseCode == 200) {
        setState(() {
          games.addAll(response[0] as List<Games>);
          currentPage = nextPage;
        });
      }
    } catch (e) {
      debugPrint('Erro ao carregar mais jogos: $e');
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (statusCode) {
      case 0:
        return LoadingScreen();
      case 200:
        return TimelineScreen(
          games: games,
          onRefresh: fetchGames,
          onSearch: searchGames,
          isLoading: isLoading,
          searchQuery: searchQuery,
          scrollController: _scrollController,
          isLoadingMore: isLoadingMore,
        );
      case 404:
      case 401:
      case 403:
      case 500:
        return ErrorScreen(
          message: 'Erro ao buscar jogos: $statusCode',
          onRefresh: fetchGames,
        );
      default:
        return ErrorScreen(
          message: 'Erro inesperado: $statusCode',
          onRefresh: fetchGames,
        );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
