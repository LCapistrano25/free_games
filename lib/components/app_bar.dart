import 'package:flutter/material.dart';

class AppNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppNavbar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.videogame_asset),
          label: 'Jogos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.devices),
          label: 'Plataformas',
        ),

      ],
    );
  }
}
