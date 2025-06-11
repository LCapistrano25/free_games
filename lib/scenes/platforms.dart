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
  final String? apiKey = 'aa70995cc7274ac099fb0dce4eb4f1e7';
  final ScrollController _scrollController = ScrollController();

  int statusCode = 0;
  int currentPage = 1;
  int totalCount = 0;
  bool isLoading = false;
  bool isLoadingMore = false;
  List<PlatformModel> platforms = [];

  @override
  void initState() {
    super.initState();
    fetchPlatforms();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final reachedBottom = _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200;
    final hasMore = platforms.length < totalCount;

    if (reachedBottom && !isLoadingMore && hasMore) {
      loadMorePlatforms();
    }
  }

  Future<void> fetchPlatforms() async {
    setState(() {
      isLoading = true;
      currentPage = 1;
    });

    try {
      final response = await PlatformServices.fetchPlatforms(apiKey!, pageSize: 20, page: 1);
      final List<PlatformModel> resultList = response[0];
      final int code = response[1];
      final int count = response[2];

      setState(() {
        statusCode = code;
        platforms = resultList;
        totalCount = count;
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

  Future<void> loadMorePlatforms() async {
    setState(() {
      isLoadingMore = true;
    });

    final nextPage = currentPage + 1;

    try {
      final response = await PlatformServices.fetchPlatforms(apiKey!, pageSize: 20, page: nextPage);
      final List<PlatformModel> newPlatforms = response[0];
      final int code = response[1];

      if (code == 200) {
        setState(() {
          platforms.addAll(newPlatforms);
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
    if (statusCode == 0) return const LoadingScreen();

    if (statusCode == 200) {
      return PlatformScreen(
        platforms: platforms,
        onRefresh: fetchPlatforms,
        isLoading: isLoading,
        isLoadingMore: isLoadingMore,
        scrollController: _scrollController,
      );
    }

    return ErrorScreen(
      title: 'Plataformas',
      message: 'Algo deu ruim… mas já tentou desligar e ligar de novo? Brincadeira! Clique no botão e vamos tentar novamente como se nada tivesse acontecido!',
      onRefresh: fetchPlatforms,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
