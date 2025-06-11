import 'package:flutter/material.dart';
import 'package:games/models/store_details.dart';
import 'package:games/screens/error_screen.dart';
import 'package:games/screens/loading_screen.dart';
import 'package:games/screens/store_screen.dart';
import 'package:games/utils/store_services.dart';

class StoreScene extends StatefulWidget {
  const StoreScene({super.key});

  @override
  State<StoreScene> createState() => _StoreSceneState();
}

class _StoreSceneState extends State<StoreScene> {
  final String? apiKey = 'aa70995cc7274ac099fb0dce4eb4f1e7';
  final ScrollController _scrollController = ScrollController();

  int statusCode = 0;
  int currentPage = 1;
  int totalCount = 0;
  bool isLoading = false;
  bool isLoadingMore = false;
  List<StoreModel> stores = [];

  @override
  void initState() {
    super.initState();
    _fetchStores();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final isNearBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;

    final hasMoreToLoad = stores.length < totalCount;

    if (isNearBottom && !isLoadingMore && hasMoreToLoad) {
      _loadMoreStores();
    }
  }

  Future<void> _fetchStores({int page = 1}) async {
    final isNewLoad = page == 1;

    setState(() {
      if (isNewLoad) {
        isLoading = true;
        currentPage = 1;
      } else {
        isLoadingMore = true;
      }
    });

    try {
      final response = await StoreServices.fetchStores(apiKey!, pageSize: 5, page: page); // 5 por página, por exemplo
      final int code = response[1] as int;
      final int count = response[2] as int;

      setState(() {
        statusCode = code;
        totalCount = count;

        if (code == 200) {
          final newStores = response[0] as List<StoreModel>;
          if (isNewLoad) {
            stores = newStores;
          } else {
            stores.addAll(newStores);
            currentPage = page;
          }
        } else {
          stores = [];
        }
      });
    } catch (e) {
      debugPrint('Erro ao buscar lojas: $e');
      setState(() {
        stores = [];
        statusCode = 500;
      });
    } finally {
      setState(() {
        isLoading = false;
        isLoadingMore = false;
      });
    }
  }

  void _loadMoreStores() => _fetchStores(page: currentPage + 1);

  @override
  Widget build(BuildContext context) {
    if (statusCode == 0) return const LoadingScreen();

    if (statusCode == 200) {
      return StoreScreen(
        stores: stores,
        onRefresh: () => _fetchStores(page: 1),
        isLoading: isLoading,
        isLoadingMore: isLoadingMore,
        scrollController: _scrollController,
      );
    }

    return ErrorScreen(
      title: 'Lojas',
      message: 'Algo deu ruim… mas já tentou desligar e ligar de novo? Brincadeira! Clique no botão e vamos tentar novamente como se nada tivesse acontecido!',
      onRefresh: () => _fetchStores(page: 1),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
