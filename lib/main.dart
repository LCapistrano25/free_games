import 'package:flutter/material.dart';
import 'package:games/models/games.dart';
import 'package:games/scenes/home.dart';
import 'package:games/scenes/timeline.dart';
import 'package:games/scenes/details_timeline.dart';
import 'package:games/scenes/platforms.dart';

void main() {
  runApp(const GamesApp());
}

class GamesApp extends StatelessWidget {
  const GamesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games App',
      home: const HomeScaffold(), // Usamos o scaffold principal com abas
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final game = settings.arguments as Games;
          return MaterialPageRoute(
            builder: (_) => DetailsTimelineScreen(detailGames: game),
          );
        }
        return null;
      },
    );
  }
}
