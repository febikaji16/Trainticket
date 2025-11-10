import 'package:flutter/material.dart';
import 'passenger_form.dart';

class AddPassengerWidget extends StatelessWidget {
  final Function(Map<String, dynamic>) onAdd;

  const AddPassengerWidget({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.add),
      label: const Text("Add Passenger"),
      onPressed: () async {
        final passenger = await showDialog<Map<String, dynamic>>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Enter Passenger Details"),
            content: PassengerForm(),
          ),
        );
        if (passenger != null) onAdd(passenger);
      },
    );
  }
}
