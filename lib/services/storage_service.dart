import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainticket/models/booking.dart';

class StorageService {
  static const _kBookingsKey = 'bookings';

  final SharedPreferences prefs;

  StorageService(this.prefs);

  List<Booking> getBookings() {
    final raw = prefs.getStringList(_kBookingsKey) ?? [];
    return raw.map((s) => Booking.fromJson(json.decode(s) as Map<String, dynamic>)).toList();
  }

  Future<void> saveBookings(List<Booking> bookings) async {
    final raw = bookings.map((b) => json.encode(b.toJson())).toList();
    await prefs.setStringList(_kBookingsKey, raw);
  }

  Future<void> addBooking(Booking booking) async {
    final bookings = getBookings();
    bookings.insert(0, booking);
    await saveBookings(bookings);
  }

  Future<void> updateBookings(List<Booking> bookings) async {
    await saveBookings(bookings);
  }
}
