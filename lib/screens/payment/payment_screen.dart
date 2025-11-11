import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:trainticket/models/booking.dart';
import 'package:trainticket/models/passenger.dart';
import 'package:trainticket/models/train.dart';
import 'package:trainticket/providers/booking_provider.dart';
import 'package:go_router/go_router.dart';

/// Mock payment screen which receives booking data through constructor (passed by router).
class PaymentScreen extends StatelessWidget {
  final Train? train;
  final List<Passenger>? passengers;
  final String? travelClass;
  final DateTime? journeyDate;
  final String? contactEmail;
  final String? contactPhone;

  const PaymentScreen({
    super.key,
    this.train,
    this.passengers,
    this.travelClass,
    this.journeyDate,
    this.contactEmail,
    this.contactPhone,
  });

  @override
  Widget build(BuildContext context) {
    final trainLocal = train;
    final passengersLocal = passengers ?? <Passenger>[];
    final travelClassLocal = travelClass ?? 'Sleeper';
    final journeyDateLocal = journeyDate ?? DateTime.now();
    final contactEmailLocal = contactEmail ?? '';
    final contactPhoneLocal = contactPhone ?? '';

    double totalFare = 0.0;
    if (trainLocal != null) {
      final fare = trainLocal.fareByClass[travelClassLocal] ?? trainLocal.cheapestFare;
      totalFare = fare * (passengersLocal.isEmpty ? 1 : passengersLocal.length);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Train: ${trainLocal?.trainName ?? '-'}'),
            const SizedBox(height: 8),
            Text('Class: $travelClassLocal'),
            const SizedBox(height: 8),
            Text('Passengers: ${passengersLocal.length}'),
            const SizedBox(height: 8),
            Text('Journey: ${journeyDateLocal.toLocal().toIso8601String().split('T').first}'),
            const SizedBox(height: 16),
            Text('Total: \u20B9${totalFare.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text('Payment Options', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text('UPI / Wallet'),
              subtitle: const Text('Mock wallet payment'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text('Credit / Debit Card'),
              subtitle: const Text('Mock card payment'),
              onTap: () {},
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Create booking and persist
                  final pnr = const Uuid().v4().split('-').first.toUpperCase();
                  final booking = Booking(
                    pnr: pnr,
                    train: trainLocal ?? Train(
                      trainNumber: 'NA',
                      trainName: 'Unknown',
                      sourceStation: '',
                      destinationStation: '',
                      departureTime: '',
                      arrivalTime: '',
                      duration: '00:00',
                      fareByClass: {},
                      availableSeats: {},
                      runningDays: [],
                    ),
                    passengers: passengersLocal,
                    travelClass: travelClassLocal,
                    bookingDate: DateTime.now(),
                    journeyDate: journeyDateLocal,
                    totalFare: totalFare,
                    contactEmail: contactEmailLocal,
                    contactPhone: contactPhoneLocal,
                  );

                  final provider = Provider.of<BookingProvider>(context, listen: false);
                  await provider.addBooking(booking);

                  // Show payment success prompt with options
                  if (!context.mounted) return;
                  await showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, size: 72, color: Colors.green),
                          const SizedBox(height: 12),
                          const Text('Payment Successful', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Your booking (PNR: ${booking.pnr}) was successful.'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            context.go('/');
                          },
                          child: const Text('Go to Home'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            context.go('/my-bookings');
                          },
                          child: const Text('My Bookings'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Pay Now'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
