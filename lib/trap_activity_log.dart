import 'package:flutter/material.dart';

class TrapActivityLogScreen extends StatelessWidget {
  const TrapActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> trapLogs = [
      {'time': 'Apr 25, 2025 10:00 AM', 'event': 'Trap armed'},
      {'time': 'Apr 25, 2025 10:45 AM', 'event': 'Motion detected'},
      {'time': 'Apr 25, 2025 10:47 AM', 'event': 'Trap triggered'},
      {'time': 'Apr 25, 2025 11:15 AM', 'event': 'Trap reset'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Trap Activity Log')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: trapLogs.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final log = trapLogs[index];
          return ListTile(
            leading: const Icon(Icons.bug_report_outlined, color: Colors.deepPurple),
            title: Text(log['event']!),
            subtitle: Text(log['time']!),
          );
        },
      ),
    );
  }
}
