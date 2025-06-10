import 'package:flutter/material.dart';
import 'package:games/models/platforms_details.dart';

class PlatformScreen extends StatelessWidget {
  final List<PlatformModel> platforms;
  final VoidCallback onRefresh;
  final Function(String) onSearch;
  final bool isLoading;
  final bool isLoadingMore;
  final String searchQuery;
  final ScrollController scrollController;

  const PlatformScreen({
    required this.platforms,
    required this.onRefresh,
    required this.onSearch,
    required this.isLoading,
    required this.isLoadingMore,
    required this.searchQuery,
    required this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plataformas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: TextEditingController(text: searchQuery),
              decoration: const InputDecoration(
                labelText: 'Buscar plataforma',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: onSearch,
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: platforms.length + (isLoadingMore ? 1 : 0),
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
                        child: InkWell(
                          onTap: () {
                            // Exemplo: ir para página com lista completa de jogos da plataforma
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
                                        height: 160,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 160,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.image_not_supported),
                                      ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        platform.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Jogos: ${platform.gamesCount}',
                                        style: const TextStyle(fontSize: 13),
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
                                              style: const TextStyle(fontSize: 11),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
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
        onPressed: onRefresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
