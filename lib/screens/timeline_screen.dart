import 'package:flutter/material.dart';
import 'package:games/components/app_routers.dart';
import 'package:games/models/games.dart';

class TimelineScreen extends StatelessWidget {
  final List<Games> games;
  final VoidCallback onRefresh;
  final Function(String) onSearch;
  final bool isLoading;
  final bool isLoadingMore;
  final String searchQuery;
  final ScrollController scrollController;

  const TimelineScreen({
    required this.games,
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
      backgroundColor: const Color(0xFFF5F8FA), // Fundo claro estilo Twitter
      appBar: AppBar(
        title: const Text('Jogos'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: TextEditingController(text: searchQuery),
              decoration: InputDecoration(
                hintText: 'Buscar jogo',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: onSearch,
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : games.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum jogo encontrado.',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                : GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(12.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 3 / 4.2,
                    ),
                    itemCount: games.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= games.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final game = games[index];
                      final sortedTags = [...game.tags]..sort((a, b) => a.name.compareTo(b.name));
                      final selectedTags = sortedTags.take(2).toList();

                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.all(2),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.details, arguments: game);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: game.backgroundImage != null
                                    ? Image.network(
                                        game.backgroundImage!,
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
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      game.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      'Avaliação: ${game.rating.toStringAsFixed(1)} ★',
                                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Metacritic: ${game.metacritic ?? 'N/A'}',
                                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                                    ),
                                    const SizedBox(height: 6),
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: -4,
                                      children: selectedTags.map((tag) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE1E8ED),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            tag.name,
                                            style: const TextStyle(fontSize: 11),
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
        onPressed: onRefresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
