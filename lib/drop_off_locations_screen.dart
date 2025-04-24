import 'package:flutter/material.dart';

class DropOffLocationsScreen extends StatelessWidget {
  const DropOffLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drop-off Locations')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Check your local pet stores, parks, and forests for safe drop off locations!',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
