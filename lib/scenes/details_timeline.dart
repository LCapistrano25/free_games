import 'package:flutter/material.dart';
import 'package:games/models/games.dart';
import 'package:games/helpers/format_date.dart';
import 'package:fl_chart/fl_chart.dart';

class DetailsTimelineScreen extends StatelessWidget {
  final Games detailGames;

  const DetailsTimelineScreen({
    required this.detailGames,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(detailGames.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (detailGames.backgroundImage != null)
              Image.network(
                detailGames.backgroundImage!,
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
                    detailGames.name,
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Lançamento
                  if (detailGames.released != null)
                    Row(
                      children: [
                        const Icon(Icons.event, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          "Lançamento: ${detailGames.released != null ? formatarData(detailGames.released!) : 'Data indisponível'}",
                        ),
                      ],
                    ),
                  const SizedBox(height: 8),

                  // Nota + Metacritic
                  Row(
                    children: [
                      const Icon(Icons.star, size: 20),
                      const SizedBox(width: 6),
                      Text("RAWG: ${detailGames.rating} / ${detailGames.ratingTop}"),
                      const SizedBox(width: 12),
                      if (detailGames.metacritic != null)
                        Chip(
                          label: Text("Metacritic: ${detailGames.metacritic}"),
                          backgroundColor: Colors.green[100],
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Tempo médio
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 20),
                      const SizedBox(width: 6),
                      Text("Tempo médio: ${detailGames.playtime}h"),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Usuários e Avaliações
                  Text("Adicionado por ${detailGames.added} usuários"),
                  Text("${detailGames.reviewsCount} avaliações, sendo ${detailGames.reviewsTextCount} com texto"),

                  const SizedBox(height: 20),

                  // Plataformas
                  if (detailGames.platforms.isNotEmpty) ...[
                    Text("Plataformas disponíveis:",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: detailGames.platforms
                          .map((p) => Chip(label: Text(p.platform.name)))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Gêneros
                  if (detailGames.genres.isNotEmpty) ...[
                    Text("Gêneros:",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: detailGames.genres
                          .map((g) => Chip(label: Text(g.name)))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Lojas
                  if (detailGames.stores.isNotEmpty) ...[
                    Text("Disponível em:",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: detailGames.stores
                          .map((s) => Chip(label: Text(s.store.name)))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Classificações (Gráfico)
                  if (detailGames.ratings.isNotEmpty) ...[
                    Text("Classificações:",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: detailGames.ratings.map((rating) {
                            return PieChartSectionData(
                              value: rating.percent.toDouble(),
                              title: '${rating.title}\n${rating.percent.toStringAsFixed(1)}%',
                              radius: 60,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                          sectionsSpace: 3,
                          centerSpaceRadius: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // ESRB Rating
                  if (detailGames.esrbRating != null)
                    Row(
                      children: [
                        const Icon(Icons.verified_user, size: 20),
                        const SizedBox(width: 6),
                        Text("Classificação etária: ${detailGames.esrbRating!.name}"),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // Tags
                  if (detailGames.tags.isNotEmpty) ...[
                    Text("Tags:",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: detailGames.tags.map((tag) => Chip(label: Text(tag.name))).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Screenshots
                  if (detailGames.screenshots.isNotEmpty) ...[
                    Text("Imagens:",
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: detailGames.screenshots.length,
                        itemBuilder: (context, index) {
                          final shot = detailGames.screenshots[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                shot.image,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Última atualização
                  Text(
                    "Última atualização: ${formatarData(detailGames.updated.split('T').first)}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
