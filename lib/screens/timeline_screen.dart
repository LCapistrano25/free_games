import 'package:flutter/material.dart';
import 'package:games/models/games.dart';

class TimelineScreen extends StatelessWidget {
  final List<Games> games;
  final VoidCallback onRefresh;

  const TimelineScreen({
    required this.games,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar jogo',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Aqui você pode filtrar os jogos
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return ListTile(
                  title: Text(game.name),
                  subtitle: Text(game.released ?? 'Data de lançamento indisponível'),
                  leading: game.backgroundImage != null
                      ? Image.network(
                          game.backgroundImage!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image_not_supported),
                  trailing: Text('${game.rating.toStringAsFixed(1)} ★'),
                  onTap: () {
                    // Ação ao clicar no jogo
                  },
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
