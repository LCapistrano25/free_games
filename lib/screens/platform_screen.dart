import 'package:flutter/material.dart';
import 'package:games/components/app_routers.dart';
import 'package:games/models/platforms_details.dart';

class PlatformScreen extends StatefulWidget {
  final List<PlatformModel> platforms;
  final VoidCallback onRefresh;
  final bool isLoading;
  final bool isLoadingMore;
  final ScrollController scrollController;

  const PlatformScreen({
    required this.platforms,
    required this.onRefresh,
    required this.isLoading,
    required this.isLoadingMore,
    required this.scrollController,
    super.key,
  });

  @override
  State<PlatformScreen> createState() => _PlatformScreenState();
}

class _PlatformScreenState extends State<PlatformScreen> {
  String searchQuery = '';
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<PlatformModel> get filteredPlatforms {
    if (searchQuery.isEmpty) return widget.platforms;
    return widget.platforms
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final platforms = filteredPlatforms;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plataformas'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Sair',
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
      ),
      backgroundColor: const Color(0xFFF5F8FA), // Fundo suave
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar plataforma',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Expanded(
            child: widget.isLoading
                ? const Center(child: CircularProgressIndicator())
                : platforms.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma plataforma encontrada.',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                : ListView.separated(
                    controller: widget.scrollController,
                    itemCount: platforms.length + (widget.isLoadingMore ? 1 : 0),
                    separatorBuilder: (_, __) => const Divider(height: 0),
                    itemBuilder: (context, index) {
                      if (index >= platforms.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final platform = platforms[index];
                      final popularGames = platform.games.take(2).toList();

                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.platformDetails, arguments: platform);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: platform.imageBackground.isNotEmpty
                                    ? Image.network(
                                        platform.imageBackground,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image, size: 40),
                                      ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      platform.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Jogos: ${platform.gamesCount}',
                                      style: const TextStyle(color: Colors.black54, fontSize: 13),
                                    ),
                                    const SizedBox(height: 6),
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: -4,
                                      children: popularGames.map((game) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE1E8ED),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            game.name,
                                            style: const TextStyle(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onRefresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
