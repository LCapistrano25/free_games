import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRefresh;

  const ErrorScreen({
    required this.message,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(message)),
      floatingActionButton: FloatingActionButton(
        onPressed: onRefresh,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
