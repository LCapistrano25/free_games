import 'package:flutter/material.dart';
import 'package:games/models/platforms_details.dart';

class DetailsPlatformScreen extends StatelessWidget {
  final PlatformModel platform;

  const DetailsPlatformScreen({
    required this.platform,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(platform.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (platform.imageBackground.isNotEmpty)
              Image.network(
                platform.imageBackground,
                height: 250,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Nome
                  Text(
                    platform.name,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Slug
                  Row(
                    children: [
                      const Icon(Icons.code, size: 20),
                      const SizedBox(width: 6),
                      Text("Slug: ${platform.slug}"),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Quantidade de jogos
                  Row(
                    children: [
                      const Icon(Icons.videogame_asset, size: 20),
                      const SizedBox(width: 6),
                      Text("Jogos disponíveis: ${platform.gamesCount}"),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Ano de início e fim
                  if (platform.yearStart != null || platform.yearEnd != null)
                    Row(
                      children: [
                        const Icon(Icons.timeline, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          "Atividade: ${platform.yearStart ?? '???'} - ${platform.yearEnd ?? 'Atual'}",
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),

                  // Lista de jogos populares
                  if (platform.games.isNotEmpty) ...[
                    Text(
                      "Jogos populares:",
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: platform.games.length,
                      itemBuilder: (context, index) {
                        final game = platform.games[index];
                        return ListTile(
                          leading: const Icon(Icons.gamepad),
                          title: Text(game.name),
                          subtitle: Text('Adicionado por ${game.added} usuários'),
                          onTap: () {
                            // Navegar para detalhes do jogo, se implementado
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Imagem secundária
                  if (platform.image != null) ...[
                    Text("Logo da plataforma:",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Center(
                      child: Image.network(
                        platform.image!,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
