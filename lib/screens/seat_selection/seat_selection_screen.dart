import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

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
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Seat booked in $selectedClass class successfully!")));
              },
              child: const Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
}
