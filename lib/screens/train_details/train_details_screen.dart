import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/availability_widget.dart';
import 'widgets/fare_breakdown_widget.dart';

class TrainDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> train = const {
    'name': 'Rajdhani Express',
    'number': '12309',
    'from': 'New Delhi',
    'to': 'Mumbai Central',
    'departure': '16:00',
    'arrival': '08:00',
    'duration': '16h',
  };

  const TrainDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${train['name']} (${train['number']})")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("From: ${train['from']} → To: ${train['to']}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Departure: ${train['departure']} | Arrival: ${train['arrival']}"),
            Text("Duration: ${train['duration']}"),
            const Divider(height: 30),

            AvailabilityWidget(),
            const SizedBox(height: 20),

            FareBreakdownWidget(),
            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Use go_router to navigate to passenger details
                  context.push('/passengerDetails');
                },
                child: const Text("Book Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
