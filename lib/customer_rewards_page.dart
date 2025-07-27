import 'package:flutter/material.dart';

class CustomerRewardsPage extends StatelessWidget {
  final List<Map<String, String>> rewards = [
    {'shop': 'Amazon.de', 'discount': '10% off'},
    {'shop': 'Zalando', 'discount': '15% off'},
    {'shop': 'MediaMarkt', 'discount': '€20 voucher'},
    {'shop': 'Otto', 'discount': 'Free Shipping'},
    {'shop': 'Saturn', 'discount': '€10 off on orders above €100'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redeem Rewards'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(reward['shop']!),
              subtitle: Text(reward['discount']!),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reward applied at ${reward['shop']}')),
                  );
                },
                child: Text('Redeem'),
              ),
            ),
          );
        },
      ),
    );
  }
}
