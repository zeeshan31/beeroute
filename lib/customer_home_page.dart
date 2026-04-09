import 'package:beeroute/landing_page.dart';
import 'package:flutter/material.dart';
import 'customer_marketplace_page.dart';
import 'customer_profile_page.dart';
import 'trip_history_page.dart'; // Import TripHistoryPage
import 'customer_rewards_page.dart'; // Import CustomerRewardsPage

class CustomerHomePage extends StatefulWidget {
  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CustomerMarketplacePage(),
    CustomerProfilePage(),
  ];

  // Dummy data for customer's trip history
  final List<Map<String, String>> customerTripHistory = [
    {'start': 'Frankfurt', 'destination': 'Cologne', 'date': '2024-01-03'},
    {'start': 'Berlin', 'destination': 'Munich', 'date': '2024-01-04'},
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
        title: const Text('Customer Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_selectedIndex == 0) _buildGamifiedStats(context), // Show gamified stats only on Marketplace tab
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
            icon: Icon(Icons.shopping_cart),
            label: 'Marketplace',
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
    final double cardWidth = MediaQuery.of(context).size.width / 3.5;
    final double cardHeight = 90;

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
                  builder: (context) => TripHistoryPage(tripHistory: customerTripHistory),
                ),
              );
            },
            child: _buildStatCard('25', 'Trips Completed', Colors.blue, cardWidth, cardHeight),
          ),
          _buildStatCard('120 kg', 'CO2 Saved', Colors.green, cardWidth, cardHeight),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerRewardsPage(), // Navigate to Rewards Page
                ),
              );
            },
            child: _buildStatCard('300', 'Rewards Earned', Colors.orange, cardWidth, cardHeight),
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
            SizedBox(height: 4),
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
