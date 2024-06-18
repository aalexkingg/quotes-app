import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Change Quote Scheduling'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Implement the functionality to change quote scheduling
              },
            ),
            ListTile(
              title: Text('Set Target Quotes'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Implement the functionality to set target quotes
              },
            ),
          ],
        ),
      ),
    );
  }
}
