import 'package:flutter/material.dart';

class AvailabilityWidget extends StatelessWidget {
  final Map<String, String> availability = const {
    'Sleeper': 'Available (32)',
    '3AC': 'WL 5',
    '2AC': 'Available (10)',
  };

  const AvailabilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Seat Availability",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...availability.entries.map((e) => ListTile(
              title: Text(e.key),
              trailing: Text(e.value),
            )),
      ],
    );
  }
}
