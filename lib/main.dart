import 'package:flutter/material.dart';
import 'package:games/models/games.dart';
import 'package:games/scenes/timeline.dart';
import 'package:games/scenes/details_timeline.dart';

void main() {
  runApp(MaterialApp(
    title: 'Games App',
    initialRoute: '/',
    routes: {
      '/': (context) => TimelineScene(), // sua tela principal com os jogos
    },
    onGenerateRoute: (settings) {
      if (settings.name == '/details') {
        final game = settings.arguments as Games;
        return MaterialPageRoute(
          builder: (_) => DetailsTimelineScreen(detailGames: game),
        );
      }
      return null;
    },
  ));
}
