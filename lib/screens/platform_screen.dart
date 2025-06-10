import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Plataformas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar plataforma',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
            ),
          ),
          Expanded(
            child: widget.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: widget.scrollController,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: platforms.length + (widget.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= platforms.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final platform = platforms[index];
                      final popularGames = platform.games.take(2).toList();

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/platform_details',
                              arguments: platform,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: platform.imageBackground.isNotEmpty
                                    ? Image.network(
                                        platform.imageBackground,
                                        width: double.infinity,
                                        height: 180,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 180,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image_not_supported),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      platform.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Jogos: ${platform.gamesCount}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 6),
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: -4,
                                      children: popularGames.map((game) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(10),
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
