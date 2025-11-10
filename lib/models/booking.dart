import 'package:trainticket/models/passenger.dart';
import 'package:trainticket/models/train.dart';

/// Model class for Booking information
class Booking {
  final String pnr;
  final Train train;
  final List<Passenger> passengers;
  final String travelClass;
  final DateTime bookingDate;
  final DateTime journeyDate;
  final double totalFare;
  final String status; // Confirmed, Cancelled, Waiting
  final String contactEmail;
  final String contactPhone;

  Booking({
    required this.pnr,
    required this.train,
    required this.passengers,
    required this.travelClass,
    required this.bookingDate,
    required this.journeyDate,
    required this.totalFare,
    this.status = 'Confirmed',
    required this.contactEmail,
    required this.contactPhone,
  });

  // Check if booking is upcoming
  bool get isUpcoming {
    return journeyDate.isAfter(DateTime.now()) && status == 'Confirmed';
  }

  // Check if booking is past
  bool get isPast {
    return journeyDate.isBefore(DateTime.now());
  }

  // Check if booking can be cancelled
  bool get canBeCancelled {
    return isUpcoming && status == 'Confirmed';
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'pnr': pnr,
      'train': train.toJson(),
      'passengers': passengers.map((p) => p.toJson()).toList(),
      'travelClass': travelClass,
      'bookingDate': bookingDate.toIso8601String(),
      'journeyDate': journeyDate.toIso8601String(),
      'totalFare': totalFare,
      'status': status,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
    };
  }

  // Create from JSON
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      pnr: json['pnr'],
      train: Train.fromJson(json['train']),
      passengers: (json['passengers'] as List)
          .map((p) => Passenger.fromJson(p))
          .toList(),
      travelClass: json['travelClass'],
      bookingDate: DateTime.parse(json['bookingDate']),
      journeyDate: DateTime.parse(json['journeyDate']),
      totalFare: json['totalFare'],
      status: json['status'],
      contactEmail: json['contactEmail'],
      contactPhone: json['contactPhone'],
    );
  }

  // Copy with method for status updates
  Booking copyWith({
    String? status,
  }) {
    return Booking(
      pnr: pnr,
      train: train,
      passengers: passengers,
      travelClass: travelClass,
      bookingDate: bookingDate,
      journeyDate: journeyDate,
      totalFare: totalFare,
      status: status ?? this.status,
      contactEmail: contactEmail,
      contactPhone: contactPhone,
    );
  }
}
