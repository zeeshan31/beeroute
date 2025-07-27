import 'package:flutter/material.dart';

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  // Dummy data for upcoming trips
  final List<Map<String, dynamic>> upcomingTrips = [
    {
      'startLocation': 'Berlin',
      'destination': 'Hamburg',
      'date': '2024-12-15',
      'time': '10:00 AM',
      'pickups': [] // Stores pickup locations for this trip
    },
    {
      'startLocation': 'München',
      'destination': 'Stuttgart',
      'date': '2024-12-16',
      'time': '3:00 PM',
      'pickups': [] // Stores pickup locations for this trip
    },
  ];

  // Add pickup location manually
  void _addPickupManually(BuildContext context, Map<String, dynamic> trip) {
    final TextEditingController _pickupController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Pickup Location'),
          content: TextField(
            controller: _pickupController,
            decoration: InputDecoration(
              labelText: 'Pickup Location',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  trip['pickups'].add(_pickupController.text.trim());
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Pickup location added successfully!")),
                );
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Add pickup location by tachometer (currently empty)
  void _addPickupByTachometer(Map<String, dynamic> trip) {
    // Placeholder for future tachometer integration
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Tachometer functionality coming soon!")),
    );
  }

  // Show options for adding pickup location
  void _showAddPickupOptions(BuildContext context, Map<String, dynamic> trip) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Pickup Location'),
          content: Text('How would you like to add the pickup location?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addPickupManually(context, trip);
              },
              child: Text('Add Manually'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addPickupByTachometer(trip);
              },
              child: Text('Add by Tachometer'),
            ),
          ],
        );
      },
    );
  }

  // Broadcast trip (for now just shows a message)
  void _broadcastTrip(Map<String, dynamic> trip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Broadcasting trip: ${trip['startLocation']} → ${trip['destination']}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upcoming Trips Section
              Text(
                'Upcoming Trips',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              upcomingTrips.isEmpty
                  ? Center(
                      child: Text(
                        'No upcoming trips to display!',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: upcomingTrips.length,
                      itemBuilder: (context, index) {
                        final trip = upcomingTrips[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('${trip['startLocation']} → ${trip['destination']}'),
                                subtitle: Text('Date: ${trip['date']} | Time: ${trip['time']}'),
                                trailing: ElevatedButton(
                                  onPressed: () => _broadcastTrip(trip),
                                  child: Text('Broadcast'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              Divider(thickness: 1),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Pickups:',
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => _showAddPickupOptions(context, trip),
                                      child: Text('Add Pickup'),
                                    ),
                                  ],
                                ),
                              ),
                              if (trip['pickups'].isNotEmpty)
                                Column(
                                  children: trip['pickups'].map<Widget>((pickup) {
                                    return ListTile(
                                      title: Text(pickup),
                                      leading: Icon(Icons.location_pin),
                                    );
                                  }).toList(),
                                ),
                              SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
