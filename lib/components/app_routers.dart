import 'package:flutter/material.dart';
import 'package:games/models/games.dart';
import 'package:games/models/platforms_details.dart';
import 'package:games/models/store_details.dart';
import 'package:games/scenes/details_platforms.dart';
import 'package:games/scenes/details_store.dart';
import 'package:games/scenes/details_timeline.dart';
import 'package:games/scenes/home.dart';
import 'package:games/scenes/login.dart'; // nova tela de login

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String details = '/details';
  static const String platformDetails = '/platform_details';
  static const String storeDetails = '/store_details';


  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(
            onLogin: () => Navigator.pushReplacementNamed(context, home),
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScaffold(),
        );
      case details:
        final game = settings.arguments as Games;
        return MaterialPageRoute(
          builder: (_) => DetailsTimelineScreen(detailGames: game),
        );
      case platformDetails:
        final platform = settings.arguments as PlatformModel;
        return MaterialPageRoute(
          builder: (_) => DetailsPlatformScreen(platform: platform),
        );
      case storeDetails:
        final store = settings.arguments as StoreModel;
        return MaterialPageRoute(
          builder: (_) => DetailsStoreScreen(store: store),
        );
      default:
        return null;
    }
  }
}
