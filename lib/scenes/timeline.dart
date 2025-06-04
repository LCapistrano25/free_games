import 'package:flutter/material.dart';
import 'package:games/models/games.dart';
import 'package:games/screens/empty_screen.dart';
import 'package:games/screens/error_screen.dart';
import 'package:games/screens/loading_screen.dart';
import 'package:games/screens/timeline_screen.dart';
import 'package:games/utils/games_services.dart';

class TimelineScene extends StatefulWidget {
  @override
  _TimelineSceneState createState() => _TimelineSceneState();
}

class _TimelineSceneState extends State<TimelineScene> {
  int statusCode = 0;
  List<Games> games = [];
  final String? apiKey = ''; // Replace with your actual API key

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  void fetchGames() async {
    setState(() {
      statusCode = 0; // Loading
    });

    if (apiKey == null || apiKey!.isEmpty) {
      setState(() {
        statusCode = 400; // Bad Request or missing key
      });
      return;
    }

    var response = await GamesServices.fetchData(apiKey!, pageSize: 10);

    setState(() {
      games = response[0] as List<Games>;
      statusCode = response[1] as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (statusCode) {
      case 0:
        return LoadingScreen();
      case 200:
        return TimelineScreen(
          games: games,
          onRefresh: fetchGames,
        );
      case 404:
        return EmptyScreen(message: 'No games found');
      default:
        return ErrorScreen(
          message: 'Error fetching games: $statusCode',
          onRefresh: fetchGames,
        );
    }
  }
}
