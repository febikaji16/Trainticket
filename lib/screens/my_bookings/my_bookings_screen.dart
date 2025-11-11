import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trainticket/providers/booking_provider.dart';
import 'package:trainticket/screens/home/widgets/app_drawer.dart';
import 'package:trainticket/widgets/left_back_menu_appbar.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookingProvider>(context);
    final bookings = provider.bookings;

    return Scaffold(
      appBar: const LeftBackMenuAppBar(title: 'My Bookings'),
      drawer: const AppDrawer(),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings yet'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: bookings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final b = bookings[index];
                return Card(
                  child: ListTile(
                    title: Text('${b.train.trainName} — ${b.train.trainNumber}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PNR: ${b.pnr}'),
                        Text('Date: ${b.journeyDate.toLocal().toIso8601String().split('T').first}'),
                        Text('Status: ${b.status}'),
                      ],
                    ),
                    trailing: b.canBeCancelled
                        ? TextButton(
                            onPressed: () {
                              final messenger = ScaffoldMessenger.of(context);
                              provider.cancelBooking(b.pnr).then((_) {
                                messenger.showSnackBar(const SnackBar(content: Text('Booking cancelled')));
                              });
                            },
                            child: const Text('Cancel'),
                          )
                        : null,
                    onTap: () {
                      context.push('/confirmation', extra: {'pnr': b.pnr});
                    },
                  ),
                );
              },
            ),
    );
  }
}
