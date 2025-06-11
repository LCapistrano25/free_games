import 'package:flutter/material.dart';
import 'package:games/models/store_details.dart';

class DetailsStoreScreen extends StatelessWidget {
  final StoreModel store;

  const DetailsStoreScreen({
    required this.store,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          store.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (store.imageBackground != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  store.imageBackground!,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),

            Text(
              store.name,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.store, size: 20, color: Colors.blueGrey),
                const SizedBox(width: 6),
                Text("Jogos disponíveis: ${store.gamesCount}"),
              ],
            ),
            const SizedBox(height: 16),

            if (store.domain != null)
              Row(
                children: [
                  const Icon(Icons.link, size: 20, color: Colors.blueGrey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      "Site: ${store.domain}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),

            if (store.games.isNotEmpty) ...[
              Text(
                "Jogos populares na loja:",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: store.games.map((game) {
                  return Chip(
                    label: Text(game.name),
                    avatar: const Icon(Icons.videogame_asset, size: 16),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
