import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:trainticket/providers/booking_provider.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String? pnr;

  const BookingConfirmationScreen({super.key, this.pnr});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);
    final booking = pnr == null ? null : provider.getByPNR(pnr!);

    return Scaffold(
      appBar: AppBar(title: const Text('Booking Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: booking == null
            ? const Center(child: Text('Booking not found'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PNR: ${booking.pnr}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Train: ${booking.train.trainName} (${booking.train.trainNumber})'),
                  const SizedBox(height: 8),
                  Text('Journey: ${booking.train.sourceStation} -> ${booking.train.destinationStation}'),
                  const SizedBox(height: 8),
                  Text('Date: ${booking.journeyDate.toLocal().toIso8601String().split('T').first}'),
                  const SizedBox(height: 8),
                  Text('Class: ${booking.travelClass}'),
                  const SizedBox(height: 8),
                  Text('Passengers: ${booking.passengers.length}'),
                  const SizedBox(height: 8),
                  Text('Total Paid: \u20B9${booking.totalFare.toStringAsFixed(2)}'),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Mock download/share - just show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ticket downloaded (mock)')));
                    },
                    child: const Text('Download Ticket'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Use go_router to navigate
                      context.go('/my-bookings');
                    },
                    child: const Text('View My Bookings'),
                  )
                ],
              ),
      ),
    );
  }
}
