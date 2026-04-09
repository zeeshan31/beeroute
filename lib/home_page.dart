import 'package:beeroute/landing_page.dart';
import 'package:flutter/material.dart';
import 'marketplace_page.dart';
import 'profile_page.dart';
import 'trip_history_page.dart'; // Import TripHistoryPage
import 'rewards_page.dart'; // Import RewardsPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DriverDashboard(), // Driver Dashboard for managing trips
    MarketplacePage(), // Marketplace
    ProfilePage(), // Profile
  ];

  // Dummy data for driver's trip history
  final List<Map<String, String>> driverTripHistory = [
    {'start': 'Berlin', 'destination': 'Hamburg', 'date': '2024-01-01'},
    {'start': 'München', 'destination': 'Stuttgart', 'date': '2024-01-02'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Manage Trips'
              : _selectedIndex == 1
                  ? 'Pickups'
                  : 'Profile',
        ),actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  LandingPage()),
              );
            },
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          if (_selectedIndex == 0) _buildGamifiedStats(context), // Show gamified stats only on dashboard
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: 'Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildGamifiedStats(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width / 2.3;
    final double cardHeight = 100;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TripHistoryPage(tripHistory: driverTripHistory),
                ),
              );
            },
            child: _buildStatCard('50', 'Trips Completed', Colors.blue, cardWidth, cardHeight),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RewardsPage(), // Navigate to Rewards Page
                ),
              );
            },
            child: _buildStatCard('€1200', 'Rewards Earned', Colors.green, cardWidth, cardHeight),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color, double width, double height) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome to the Driver Dashboard!',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
