import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String message;

  const EmptyScreen({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(message)),
    );
  }
}
