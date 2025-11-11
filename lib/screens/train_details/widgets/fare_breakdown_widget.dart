import 'package:flutter/material.dart';

class FareBreakdownWidget extends StatelessWidget {
  final Map<String, int> fares = const {
    'Sleeper': 450,
    '3AC': 900,
    '2AC': 1200,
  };

  const FareBreakdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Fare Breakdown",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...fares.entries.map((e) => ListTile(
              title: Text(e.key),
              trailing: Text("₹${e.value}"),
            )),
      ],
    );
  }
}
