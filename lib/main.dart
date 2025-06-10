import 'package:flutter/material.dart';
import 'package:games/models/games.dart';
import 'package:games/models/platforms_details.dart';
import 'package:games/scenes/details_platforms.dart';
import 'package:games/scenes/home.dart';
import 'package:games/scenes/details_timeline.dart';

void main() {
  runApp(const GamesApp());
}

class GamesApp extends StatelessWidget {
  const GamesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games App',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScaffold(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/details':
            final game = settings.arguments as Games;
            return MaterialPageRoute(
              builder: (_) => DetailsTimelineScreen(detailGames: game),
              settings: settings, // ✅ ajuda a atualizar a rota
            );
          case '/platform_details':
            final platform = settings.arguments as PlatformModel;
            return MaterialPageRoute(
              builder: (_) => DetailsPlatformScreen(platform: platform),
              settings: settings, // ✅ ajuda a atualizar a rota
            );
          default:
            return null;
        }
      },
    );
  }
}
