import 'package:flutter/material.dart';
import 'package:trainticket/models/train.dart';
import 'package:trainticket/models/passenger.dart';
import 'package:go_router/go_router.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Train? train;
  final List<Passenger>? passengers;
  final DateTime? journeyDate;
  final String? contactEmail;
  final String? contactPhone;

  const SeatSelectionScreen({super.key, this.train, this.passengers, this.journeyDate, this.contactEmail, this.contactPhone});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  String selectedClass = 'Sleeper';

  final Map<String, int> fares = {
    'Sleeper': 450,
    '3AC': 900,
    '2AC': 1200,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seat Selection")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ...fares.entries.map((entry) => RadioListTile<String>(
                  title: Text("${entry.key} (₹${entry.value})"),
                  value: entry.key,
                  groupValue: selectedClass,
                  onChanged: (val) => setState(() => selectedClass = val!),
                )),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Move to payment screen with collected data
                final train = widget.train;
                final passengers = widget.passengers ?? <Passenger>[];
                final journeyDate = widget.journeyDate;
                final email = widget.contactEmail;
                final phone = widget.contactPhone;
                context.push('/payment', extra: {
                  'train': train,
                  'passengers': passengers,
                  'travelClass': selectedClass,
                  'journeyDate': journeyDate,
                  'contactEmail': email,
                  'contactPhone': phone,
                });
              },
              child: const Text("Confirm & Pay"),
            ),
          ],
        ),
      ),
    );
  }
}
