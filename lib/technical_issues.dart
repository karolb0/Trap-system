import 'package:flutter/material.dart';

class TechnicalIssuesScreen extends StatelessWidget {
  const TechnicalIssuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final issues = [
      {
        'title': 'Trap won’t close',
        'solution': 'Make sure the latch is clean and the battery is charged.'
      },
      {
        'title': 'Sensor not detecting motion',
        'solution': 'Wipe the sensor gently and check its wiring.'
      },
      {
        'title': 'Door won’t reset',
        'solution': 'Hold the reset button for 5 seconds and try again.'
      },
      {
        'title': 'No response from device',
        'solution': 'Check your internet connection and restart the trap.'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Technical Support')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: issues.length,
        itemBuilder: (context, index) {
          final issue = issues[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.build_circle_outlined, color: Colors.deepPurple),
              title: Text(issue['title']!),
              subtitle: Text(issue['solution']!),
            ),
          );
        },
      ),
    );
  }
}
