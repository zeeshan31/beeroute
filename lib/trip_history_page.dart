import 'package:flutter/material.dart';

class TripHistoryPage extends StatelessWidget {
  final List<Map<String, String>> tripHistory;

  // Pass trip history as a parameter
  TripHistoryPage({required this.tripHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip History'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: tripHistory.isEmpty
          ? Center(
              child: Text(
                'No trips to display!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: tripHistory.length,
              itemBuilder: (context, index) {
                final trip = tripHistory[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text('${trip['start']} → ${trip['destination']}'),
                    subtitle: Text('Date: ${trip['date']}'),
                  ),
                );
              },
            ),
    );
  }
}
