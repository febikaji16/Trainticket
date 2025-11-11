import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trainticket/models/passenger.dart';
import 'package:trainticket/models/train.dart';
// import 'widgets/passenger_form.dart';
import 'widgets/add_passenger_widget.dart';

class PassengerDetailsScreen extends StatefulWidget {
  final Train? train;
  final DateTime? journeyDate;

  const PassengerDetailsScreen({super.key, this.train, this.journeyDate});

  @override
  State<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends State<PassengerDetailsScreen> {
  final List<Map<String, dynamic>> passengers = [];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
            if (widget.train != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${widget.train!.trainName} (${widget.train!.trainNumber})', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('Journey: ${widget.train!.sourceStation} → ${widget.train!.destinationStation}'),
                    if (widget.journeyDate != null) Text('Date: ${widget.journeyDate!.toLocal().toIso8601String().split('T').first}'),
                  ],
                ),
              ),

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
            Text("Total Fare: ₹${calculateTotalFare()}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Contact Email (optional)'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Contact Phone (optional)'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // convert passenger maps to model objects
                final List<Passenger> modelPassengers = passengers.map((p) => Passenger.fromJson(p)).toList();
                context.push('/seatSelection', extra: {
                  'train': widget.train,
                  'passengers': modelPassengers,
                  'journeyDate': widget.journeyDate,
                  'contactEmail': _emailController.text,
                  'contactPhone': _phoneController.text,
                });
              },
              child: const Text("Continue to Seat Selection"),
            ),
          ],
        ),
      ),
    );
  }
}
