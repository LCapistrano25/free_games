import 'package:flutter/material.dart';
import 'package:games/models/platforms_details.dart';
import 'package:games/screens/error_screen.dart';
import 'package:games/screens/loading_screen.dart';
import 'package:games/screens/platform_screen.dart';
import 'package:games/utils/platform_services.dart';

class PlatformScene extends StatefulWidget {
  @override
  _PlatformSceneState createState() => _PlatformSceneState();
}

class _PlatformSceneState extends State<PlatformScene> {
  int statusCode = 0;
  int currentPage = 1;
  bool isLoading = false;
  bool isLoadingMore = false;
  List<PlatformModel> platforms = [];
  final ScrollController _scrollController = ScrollController();
  final String? apiKey = 'aa70995cc7274ac099fb0dce4eb4f1e7';

  @override
  void initState() {
    super.initState();
    fetchPlatforms();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore) {
      loadMorePlatforms();
    }
  }

  void fetchPlatforms() async {
    setState(() {
      isLoading = true;
      currentPage = 1;
    });

    try {
      var response = await PlatformServices.fetchPlatforms(apiKey!, pageSize: 20, page: 1);
      setState(() {
        platforms = response[0] as List<PlatformModel>;
        statusCode = (response.length > 1 && response[1] is int) ? response[1] as int : 500;
      });
    } catch (e) {
      debugPrint('Erro ao buscar plataformas: $e');
      setState(() {
        platforms = [];
        statusCode = 500;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void loadMorePlatforms() async {
    setState(() {
      isLoadingMore = true;
    });

    int nextPage = currentPage + 1;

    try {
      var response = await PlatformServices.fetchPlatforms(apiKey!, pageSize: 20, page: nextPage);

      final int responseCode = (response.length > 1 && response[1] is int) ? response[1] as int : 500;

      if (responseCode == 200) {
        setState(() {
          platforms.addAll(response[0] as List<PlatformModel>);
          currentPage = nextPage;
        });
      }
    } catch (e) {
      debugPrint('Erro ao carregar mais plataformas: $e');
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
        return PlatformScreen(
          platforms: platforms,
          onRefresh: fetchPlatforms,
          onSearch: (_) {}, // Não usado, mas requerido pela tela
          isLoading: isLoading,
          isLoadingMore: isLoadingMore,
          searchQuery: '', // Ignorado
          scrollController: _scrollController,
        );
      case 404:
      case 401:
      case 403:
      case 500:
        return ErrorScreen(
          message: 'Erro ao buscar plataformas: $statusCode',
          onRefresh: fetchPlatforms,
        );
      default:
        return ErrorScreen(
          message: 'Erro inesperado: $statusCode',
          onRefresh: fetchPlatforms,
        );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
