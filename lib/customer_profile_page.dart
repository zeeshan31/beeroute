import 'package:flutter/material.dart';

class CustomerProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy customer data
    final String customerName = "Max Mustermann";
    final String contactNumber = "+49 123 456 7890";
    final String email = "max.mustermann@example.com";
    final String pickupAddress = "Hauptstraße 123, 10115 Berlin";
    final List<Map<String, String>> recentOrders = [
      {'start': 'Berlin', 'destination': 'Hamburg', 'date': '2024-12-15'},
      {'start': 'München', 'destination': 'Stuttgart', 'date': '2024-11-10'},
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/customer_avatar.png'), // Ensure this image exists
                ),
              ),
              SizedBox(height: 20),

              // Customer Name
              _buildProfileDetail('Name', customerName),
              SizedBox(height: 10),

              // Contact Number
              _buildProfileDetail('Contact Number', contactNumber),
              SizedBox(height: 10),

              // Email Address
              _buildProfileDetail('Email', email),
              SizedBox(height: 10),

              // Pickup Address
              _buildProfileDetail('Preferred Pickup Address', pickupAddress),
              SizedBox(height: 20),

              // Recent Orders Section
              Text(
                'Recent Orders',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              recentOrders.isEmpty
                  ? Center(
                      child: Text(
                        'No recent orders yet.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: recentOrders.length,
                      itemBuilder: (context, index) {
                        final order = recentOrders[index];
                        return Card(
                          child: ListTile(
                            title: Text('${order['start']} → ${order['destination']}'),
                            subtitle: Text('Date: ${order['date']}'),
                          ),
                        );
                      },
                    ),
              SizedBox(height: 20),

              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  // Placeholder for future edit functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Edit profile feature coming soon!")),
                  );
                },
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget to Display Profile Details
  Widget _buildProfileDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
