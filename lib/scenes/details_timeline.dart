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
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          detailGames.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (detailGames.backgroundImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  detailGames.backgroundImage!,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),

            Text(
              detailGames.name,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            if (detailGames.released != null)
              _iconRow(Icons.event, "Lançamento: ${formatarData(detailGames.released!)}"),
            const SizedBox(height: 8),

            _iconRow(Icons.star, "RAWG: ${detailGames.rating} / ${detailGames.ratingTop}"),
            if (detailGames.metacritic != null)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Chip(
                  label: Text("Metacritic: ${detailGames.metacritic}"),
                  backgroundColor: Colors.green[100],
                ),
              ),
            const SizedBox(height: 12),

            _iconRow(Icons.timer, "Tempo médio: ${detailGames.playtime}h"),
            const SizedBox(height: 12),

            Text("Adicionado por ${detailGames.added} usuários"),
            Text("${detailGames.reviewsCount} avaliações, sendo ${detailGames.reviewsTextCount} com texto"),
            const SizedBox(height: 16),

            _buildChipsSection("Plataformas disponíveis", detailGames.platforms.map((e) => e.platform.name).toList()),
            _buildChipsSection("Gêneros", detailGames.genres.map((g) => g.name).toList()),
            _buildChipsSection("Disponível em", detailGames.stores.map((s) => s.store.name).toList()),

            if (detailGames.ratings.isNotEmpty) ...[
              Text("Classificações:", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
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

            if (detailGames.esrbRating != null)
              _iconRow(Icons.verified_user, "Classificação etária: ${detailGames.esrbRating!.name}"),

            _buildChipsSection("Tags", detailGames.tags.map((tag) => tag.name).toList()),

            if (detailGames.screenshots.isNotEmpty) ...[
              Text("Imagens:", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
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
                        borderRadius: BorderRadius.circular(12),
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

            Text(
              "Última atualização: ${formatarData(detailGames.updated.split('T').first)}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _iconRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        const SizedBox(width: 6),
        Expanded(child: Text(text)),
      ],
    );
  }

  Widget _buildChipsSection(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: items
              .map((item) => Chip(
                    label: Text(item),
                    backgroundColor: const Color(0xFFE1E8ED),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
