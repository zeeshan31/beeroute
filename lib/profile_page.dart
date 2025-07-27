import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for the driver profile
    final String driverName = "John Doe";
    final String driverCode = "DR12345";
    final String vehicleType = "Truck";
    final String numberPlate = "XYZ-1234";
    final String contactNumber = "+1 123 456 7890";
    final String email = "johndoe@example.com";
    final String loadCapacity = "10 Tons";
    final String vehicleDimensions = "12m x 3m x 3.5m";

    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Driver Avatar
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/driver_avatar.png'), // Add an avatar image in assets
                ),
              ),
              SizedBox(height: 20),

              // Driver Name
              _buildProfileDetail('Name', driverName),
              SizedBox(height: 10),

              // Driver Code
              _buildProfileDetail('Driver Code', driverCode),
              SizedBox(height: 10),

              // Vehicle Type
              _buildProfileDetail('Vehicle Type', vehicleType),
              SizedBox(height: 10),

              // Number Plate
              _buildProfileDetail('Number Plate', numberPlate),
              SizedBox(height: 10),

              // Load Capacity
              _buildProfileDetail('Load Capacity', loadCapacity),
              SizedBox(height: 10),

              // Vehicle Dimensions
              _buildProfileDetail('Vehicle Dimensions', vehicleDimensions),
              SizedBox(height: 10),

              // Contact Number
              _buildProfileDetail('Contact Number', contactNumber),
              SizedBox(height: 10),

              // Email
              _buildProfileDetail('Email', email),
              SizedBox(height: 20),

              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  // Logic to edit profile (future implementation)
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
