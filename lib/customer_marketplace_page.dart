import 'package:beeroute/mock/mocklist.dart';
import 'package:flutter/material.dart';

class CustomerMarketplacePage extends StatefulWidget {
  @override
  _CustomerMarketplacePageState createState() => _CustomerMarketplacePageState();
}

class _CustomerMarketplacePageState extends State<CustomerMarketplacePage> {
  final TextEditingController _startLocationController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  // Dummy data with German cities


  List<Map<String, String>> alerts = []; // List to store alerts
  List<Map<String, String>> searchResults = [];
  Map<String, List<String>> selectedDropOffs = {}; // Store selected drop-offs per trip

  // Suggested drop-off points
  final Map<String, List<String>> suggestedDropOffs = {
    'Berlin → Hamburg': ['Checkpoint Charlie', 'Alexanderplatz', 'Hamburg Hbf'],
    'München → Stuttgart': ['Marienplatz', 'Olympiapark', 'Stuttgart Hbf'],
    'Frankfurt → Köln': ['Frankfurt Hbf', 'Mainz', 'Köln Dom'],
  };

  // Search trips
  void _searchTrips() {
    String startLocation = _startLocationController.text.trim();
    String destination = _destinationController.text.trim();

    setState(() {
      searchResults = availableTrips.where((trip) {
        return trip['startLocation']!.toLowerCase() == startLocation.toLowerCase() &&
            trip['destination']!.toLowerCase() == destination.toLowerCase();
      }).toList();
    });

    if (searchResults.isEmpty) {
      _showNoTripsDialog();
    }
  }

  // Add alert
  void _addAlert() {
    String startLocation = _startLocationController.text.trim();
    String destination = _destinationController.text.trim();

    setState(() {
      alerts.add({'startLocation': startLocation, 'destination': destination});
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Alert added for $startLocation → $destination")),
    );
  }

  // Show dialog when no trips are found
  void _showNoTripsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('No Trips Found'),
          content: Text('Would you like to set an alert for this route?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addAlert();
                Navigator.pop(context);
              },
              child: Text('Set Alert'),
            ),
          ],
        );
      },
    );
  }

  // Handle trip selection and drop-off positions
  void _selectDropOffPositions(Map<String, String> trip) {
    final tripKey = '${trip['startLocation']} → ${trip['destination']}';
    List<String> dropOffOptions = suggestedDropOffs[tripKey] ?? [];
    String? selectedOption;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.0,
            right: 16.0,
            top: 20.0,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Drop-Off Positions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: selectedOption,
                    hint: Text('Select a drop-off point'),
                    items: dropOffOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setModalState(() {
                        selectedOption = newValue;
                        if (selectedOption != null) {
                          selectedDropOffs.putIfAbsent(tripKey, () => []);
                          if (!selectedDropOffs[tripKey]!.contains(selectedOption)) {
                            selectedDropOffs[tripKey]!.add(selectedOption!);
                          }
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Selected Drop-Off Positions:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ...selectedDropOffs[tripKey]?.map((position) => ListTile(
                        title: Text(position),
                      )) ??
                      [],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close modal after confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Drop-Off Positions Confirmed")),
                      );
                    },
                    child: Text('Confirm Positions'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
void _showBidDialog(BuildContext context, Map<String, String> trip, int index) {
  String bidAmount = trip['bidAmount'] != null && trip['bidAmount'] != '0' ? trip['bidAmount']! : '';
  TextEditingController _controller = TextEditingController(text: bidAmount);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Bid for ${trip['startLocation']} → ${trip['destination']}"),
        content: TextField(
          controller: _controller,
          onChanged: (value) {
            bidAmount = value;
          },
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Enter your bid (€)"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (bidAmount.isNotEmpty &&
                  int.tryParse(bidAmount) != null &&
                  int.parse(bidAmount) > 0) {
                setState(() {
                  availableTrips[index]['bidAmount'] = bidAmount;
                });
              }
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("You bid €$bidAmount for this trip.")),
              );
            },
            child: const Text("Submit"),
          ),
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Inputs
            TextField(
              controller: _startLocationController,
              decoration: InputDecoration(
                labelText: 'Start Location',
                prefixIcon: Icon(Icons.location_on),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Destination',
                prefixIcon: Icon(Icons.flag),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchTrips,
              child: Text('Search'),
            ),
            SizedBox(height: 20),

            // Search Results
            Text(
              'Search Results',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            searchResults.isEmpty
                ? Center(
                    child: Text(
                      'No results yet. Try searching!',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final trip = searchResults[index];
                      final tripKey = '${trip['startLocation']} → ${trip['destination']}';
                      return Card(
                        child: ListTile(
                          title: Text('${trip['startLocation']} → ${trip['destination']}'),
                          subtitle: Text('Date: ${trip['date']} | Time: ${trip['time']}'),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () => _selectDropOffPositions(trip),
                          onLongPress: () {
                            if (selectedDropOffs.containsKey(tripKey)) {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ListView(
                                    children: selectedDropOffs[tripKey]!
                                        .map((e) => ListTile(title: Text(e)))
                                        .toList(),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),Expanded(
  child: ListView.builder(
    itemCount: availableTrips.length,
    itemBuilder: (context, index) {
  final trip = availableTrips[index];
  final hasBid = trip['bidAmount'] != null && trip['bidAmount'] != '0';

  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    elevation: 3,
    child: ListTile(
      title: Text('${trip['startLocation']} → ${trip['destination']}'),
      subtitle: Text('${trip['date']} at ${trip['time']}'),
      trailing: hasBid
    ? OutlinedButton(
  style: OutlinedButton.styleFrom(
    minimumSize: Size(10, 36), // width, height
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    side: BorderSide(color: Colors.orange),
    foregroundColor: Colors.orange,
    textStyle: TextStyle(fontSize: 13),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  ),
  onPressed: () => _showBidDialog(context, trip, index),
  child: Text(
    'Already bid: €${trip['bidAmount']}',
    style: TextStyle(fontSize: 13, color: Colors.orange),
  ),
)
    : ElevatedButton(
        onPressed: () => _showBidDialog(context, trip, index),
        child: const Text('Bid'),
      ),

        
    ),
  );
},

  ),
),

          ],
        ),
      ),
    );
  }
}
