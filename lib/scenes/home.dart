import 'package:flutter/material.dart';
import 'package:games/scenes/platforms.dart';
import 'package:games/scenes/timeline.dart';
import 'package:games/scenes/store.dart';

// Adicione mais telas se quiser

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens =  [
    TimelineScene(),
    PlatformScene(),
    StoreScene(),
    // Adicione aqui, ex: FavoritesScene()
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Jogos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Plataformas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Loja',
          ),
        ],
      ),
    );
  }
}
