import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trainticket/constants/colors.dart';
import 'package:trainticket/data/mock_trains.dart';
import 'package:trainticket/models/train.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trainticket/services/auth_service.dart';

class SearchResultsScreen extends StatelessWidget {
  final Map<String, dynamic> searchParams;

  const SearchResultsScreen({
    super.key,
    required this.searchParams,
  });

  List<Train> _getFilteredTrains() {
    final String from = searchParams['from'] as String;
    final String to = searchParams['to'] as String;
    final DateTime date = DateTime.parse(searchParams['date'] as String);
    final String dayOfWeek = DateFormat('E').format(date).substring(0, 3);

    // Filter trains based on source, destination, and running days
    return MockTrains.trains.where((train) {
      return train.sourceStation.contains(from.toUpperCase()) &&
          train.destinationStation.contains(to.toUpperCase()) &&
          train.runsOnDay(dayOfWeek);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final String from = searchParams['from'] as String;
    final String to = searchParams['to'] as String;
    final String date = searchParams['date'] as String;
    final List<Train> filteredTrains = _getFilteredTrains();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Results'),
      ),
      body: Column(
        children: [
          // Search summary card
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.train, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '$from to $to',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        date.split(' ')[0],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Train list
          Expanded(
            child: filteredTrains.isEmpty
                ? const Center(
                    child: Text(
                      'No trains found for this route on the selected date.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredTrains.length,
                    itemBuilder: (context, index) {
                      final train = filteredTrains[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ExpansionTile(
                          title: Text(train.trainName),
                          subtitle: Text('${train.trainNumber} • ${train.departureTime} - ${train.arrivalTime}'),
                          trailing: Text(
                            '₹${train.cheapestFare.toStringAsFixed(0)}+',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Duration: ${train.duration}'),
                                  const SizedBox(height: 8),
                                  const Text('Available Classes:'),
                                  const SizedBox(height: 4),
                                  ...train.fareByClass.entries.map((entry) {
                                    final seats = train.availableSeats[entry.key] ?? 0;
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${entry.key}: ₹${entry.value.toStringAsFixed(0)}'),
                                          Text('$seats seats available'),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Check login status before booking
                                        final auth = Provider.of<AuthService>(context, listen: false);
                                        if (auth.isLoggedIn) {
                                          // Navigate to passenger details with selected train and journey date
                                          context.push('/passengerDetails', extra: {
                                            'train': train,
                                            'journeyDate': DateTime.parse(date),
                                          });
                                        } else {
                                          // Prompt user to login
                                          showDialog<void>(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: const Text('Login required'),
                                              content: const Text('You must be logged in to book a ticket.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.of(ctx).pop(),
                                                  child: const Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                    context.push('/login');
                                                  },
                                                  child: const Text('Login'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      child: const Text('Book Now'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}