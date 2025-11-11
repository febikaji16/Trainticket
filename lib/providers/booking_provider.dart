import 'package:flutter/foundation.dart';
import 'package:trainticket/models/booking.dart';
import 'package:trainticket/services/storage_service.dart';

class BookingProvider extends ChangeNotifier {
  final StorageService storage;

  List<Booking> _bookings = [];

  BookingProvider({required this.storage}) {
    _load();
  }

  List<Booking> get bookings => List.unmodifiable(_bookings);

  Future<void> _load() async {
    _bookings = storage.getBookings();
    notifyListeners();
  }

  Future<void> addBooking(Booking booking) async {
    _bookings.insert(0, booking);
    await storage.addBooking(booking);
    notifyListeners();
  }

  Future<void> cancelBooking(String pnr) async {
    final idx = _bookings.indexWhere((b) => b.pnr == pnr);
    if (idx == -1) return;
    final updated = _bookings[idx].copyWith(status: 'Cancelled');
    _bookings[idx] = updated;
    await storage.updateBookings(_bookings);
    notifyListeners();
  }

  Booking? getByPNR(String pnr) {
    try {
      return _bookings.firstWhere((b) => b.pnr == pnr);
    } catch (_) {
      return null;
    }
  }
}
