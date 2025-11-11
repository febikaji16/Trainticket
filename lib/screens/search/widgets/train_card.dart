import 'package:flutter/material.dart';
import 'package:trainticket/models/train.dart';

/// Card widget displaying train information in search results
class TrainCard extends StatelessWidget {
  final Train train;
  final VoidCallback onTap;

  const TrainCard({
    super.key,
    required this.train,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Train name and number
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          train.trainName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '#${train.trainNumber}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Cheapest fare chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '₹${train.cheapestFare.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              
              // Timing and duration
              Row(
                children: [
                  // Departure
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          train.departureTime,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          train.sourceStation,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Duration arrow
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[400])),
                            Icon(Icons.arrow_forward, size: 16, color: Colors.grey[600]),
                            Expanded(child: Divider(color: Colors.grey[400])),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          train.duration,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Arrival
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          train.arrivalTime,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          train.destinationStation,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Available classes
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: train.fareByClass.entries.map((entry) {
                  final availableSeats = train.availableSeats[entry.key] ?? 0;
                  return Chip(
                    label: Text(
                      '${entry.key}: ₹${entry.value.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 11),
                    ),
                    backgroundColor: availableSeats > 20
                        ? Colors.green[50]
                        : availableSeats > 0
                            ? Colors.orange[50]
                            : Colors.red[50],
                    avatar: CircleAvatar(
                      backgroundColor: availableSeats > 20
                          ? Colors.green
                          : availableSeats > 0
                              ? Colors.orange
                              : Colors.red,
                      child: Text(
                        availableSeats.toString(),
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
              // Running days
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Runs: ${train.runningDays.join(", ")}',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
