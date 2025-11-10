import 'package:flutter/material.dart';
// import 'widgets/passenger_form.dart';
import 'widgets/add_passenger_widget.dart';

class PassengerDetailsScreen extends StatefulWidget {
  const PassengerDetailsScreen({super.key});

  @override
  State<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends State<PassengerDetailsScreen> {
  final List<Map<String, dynamic>> passengers = [];

  void addPassenger(Map<String, dynamic> passenger) {
    setState(() {
      passengers.add(passenger);
    });
  }

  void removePassenger(int index) {
    setState(() {
      passengers.removeAt(index);
    });
  }

  int calculateTotalFare() {
    const int farePerPerson = 900; // can depend on class selection
    return passengers.length * farePerPerson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Passenger Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AddPassengerWidget(onAdd: addPassenger),
            Expanded(
              child: ListView.builder(
                itemCount: passengers.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text("${passengers[index]['name']} (${passengers[index]['age']})"),
                    subtitle: Text("Gender: ${passengers[index]['gender']}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removePassenger(index),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Total Fare: ₹${calculateTotalFare()}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/seatSelection'),
              child: const Text("Continue to Seat Selection"),
            ),
          ],
        ),
      ),
    );
  }
}
