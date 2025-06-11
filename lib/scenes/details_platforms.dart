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
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          platform.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (platform.imageBackground.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  platform.imageBackground,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),

            Text(
              platform.name,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _iconRow(Icons.code, "Slug: ${platform.slug}"),
            const SizedBox(height: 8),
            _iconRow(Icons.videogame_asset, "Jogos disponíveis: ${platform.gamesCount}"),
            const SizedBox(height: 8),

            if (platform.yearStart != null || platform.yearEnd != null)
              _iconRow(
                Icons.timeline,
                "Atividade: ${platform.yearStart ?? '???'} - ${platform.yearEnd ?? 'Atual'}",
              ),
            const SizedBox(height: 20),

            if (platform.games.isNotEmpty)
              _buildChipsSection(
                "Jogos populares",
                platform.games.map((g) => g.name).toList(),
                icon: Icons.local_fire_department,
              ),

            if (platform.image != null) ...[
              Row(
                children: const [
                  Icon(Icons.image, size: 20),
                  SizedBox(width: 6),
                  Text(
                    "Logo da plataforma:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    platform.image!,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
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

  Widget _buildChipsSection(String title, List<String> items, {IconData? icon}) {
    if (items.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) Icon(icon, size: 20),
            if (icon != null) const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
