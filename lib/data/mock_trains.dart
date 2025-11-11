import 'package:trainticket/models/train.dart';

/// Hardcoded train data for the application
class MockTrains {
  static final List<Train> trains = [
    // Delhi to Mumbai Trains
    Train(
      trainNumber: '12951',
      trainName: 'Mumbai Rajdhani Express',
      sourceStation: 'NDLS',
      destinationStation: 'BCT',
      departureTime: '16:55',
      arrivalTime: '08:35',
      duration: '15:40',
      fareByClass: {
        '1A': 4200.0,
        '2A': 2800.0,
        '3A': 2100.0,
      },
      availableSeats: {
        '1A': 15,
        '2A': 42,
        '3A': 28,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['AGC', 'GWL', 'JHS', 'BPL', 'NGP', 'BSL'],
    ),
    Train(
      trainNumber: '12953',
      trainName: 'August Kranti Rajdhani',
      sourceStation: 'NDLS',
      destinationStation: 'BCT',
      departureTime: '17:05',
      arrivalTime: '09:05',
      duration: '16:00',
      fareByClass: {
        '1A': 4150.0,
        '2A': 2750.0,
        '3A': 2050.0,
      },
      availableSeats: {
        '1A': 8,
        '2A': 35,
        '3A': 45,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['KOT', 'SWM', 'BRC', 'ST'],
    ),
    Train(
      trainNumber: '12137',
      trainName: 'Punjab Mail',
      sourceStation: 'NDLS',
      destinationStation: 'CSMT',
      departureTime: '18:30',
      arrivalTime: '13:40',
      duration: '19:10',
      fareByClass: {
        '1A': 3200.0,
        '2A': 2100.0,
        '3A': 1500.0,
        'SL': 550.0,
      },
      availableSeats: {
        '1A': 12,
        '2A': 50,
        '3A': 60,
        'SL': 120,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['RTK', 'UJN', 'NAD', 'BRC', 'ST', 'KYN'],
    ),

    // Delhi to Bangalore Trains
    Train(
      trainNumber: '12429',
      trainName: 'Rajdhani Express',
      sourceStation: 'NDLS',
      destinationStation: 'SBC',
      departureTime: '20:15',
      arrivalTime: '05:50',
      duration: '33:35',
      fareByClass: {
        '1A': 6200.0,
        '2A': 4100.0,
        '3A': 3000.0,
      },
      availableSeats: {
        '1A': 10,
        '2A': 38,
        '3A': 52,
      },
      runningDays: ['Mon', 'Wed', 'Fri', 'Sat'],
      stopsInBetween: ['BPL', 'NGP', 'BZA', 'GTL'],
    ),
    Train(
      trainNumber: '12639',
      trainName: 'Brindavan Express',
      sourceStation: 'MAS',
      destinationStation: 'SBC',
      departureTime: '07:00',
      arrivalTime: '13:45',
      duration: '06:45',
      fareByClass: {
        '2A': 980.0,
        '3A': 720.0,
        'CC': 650.0,
        'SL': 320.0,
      },
      availableSeats: {
        '2A': 42,
        '3A': 68,
        'CC': 85,
        'SL': 150,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['AJJ', 'KPD', 'JTJ'],
    ),

    // Mumbai to Bangalore Trains
    Train(
      trainNumber: '12163',
      trainName: 'Dadar Express',
      sourceStation: 'LTT',
      destinationStation: 'SBC',
      departureTime: '20:10',
      arrivalTime: '08:45',
      duration: '12:35',
      fareByClass: {
        '1A': 2800.0,
        '2A': 1850.0,
        '3A': 1350.0,
        'SL': 510.0,
      },
      availableSeats: {
        '1A': 18,
        '2A': 55,
        '3A': 72,
        'SL': 140,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['PUNE', 'SUR', 'GDG'],
    ),

    // Kolkata to Delhi Trains
    Train(
      trainNumber: '12302',
      trainName: 'Kolkata Rajdhani',
      sourceStation: 'HWH',
      destinationStation: 'NDLS',
      departureTime: '17:00',
      arrivalTime: '10:05',
      duration: '17:05',
      fareByClass: {
        '1A': 4500.0,
        '2A': 3000.0,
        '3A': 2200.0,
      },
      availableSeats: {
        '1A': 20,
        '2A': 48,
        '3A': 62,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['DHN', 'GAYA', 'MGS', 'ALD', 'CNB'],
    ),

    // Chennai to Delhi Trains
    Train(
      trainNumber: '12622',
      trainName: 'Tamil Nadu Express',
      sourceStation: 'MAS',
      destinationStation: 'NDLS',
      departureTime: '22:00',
      arrivalTime: '06:50',
      duration: '32:50',
      fareByClass: {
        '1A': 5800.0,
        '2A': 3800.0,
        '3A': 2800.0,
        'SL': 980.0,
      },
      availableSeats: {
        '1A': 16,
        '2A': 52,
        '3A': 78,
        'SL': 180,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['KPD', 'RU', 'BZA', 'NGP', 'BPL', 'AGC'],
    ),

    // Mumbai to Chennai Trains
    Train(
      trainNumber: '12164',
      trainName: 'Chennai Express',
      sourceStation: 'LTT',
      destinationStation: 'MAS',
      departureTime: '11:40',
      arrivalTime: '13:15',
      duration: '25:35',
      fareByClass: {
        '1A': 4200.0,
        '2A': 2800.0,
        '3A': 2050.0,
        'SL': 750.0,
      },
      availableSeats: {
        '1A': 14,
        '2A': 46,
        '3A': 68,
        'SL': 165,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['PUNE', 'SUR', 'GDG', 'GTL', 'BZA', 'OGL'],
    ),

    // Jaipur to Delhi Trains
    Train(
      trainNumber: '12015',
      trainName: 'Ajmer Shatabdi',
      sourceStation: 'JP',
      destinationStation: 'NDLS',
      departureTime: '16:05',
      arrivalTime: '21:10',
      duration: '05:05',
      fareByClass: {
        'CC': 820.0,
        'EC': 1520.0,
      },
      availableSeats: {
        'CC': 125,
        'EC': 25,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['FL', 'BKI'],
    ),

    // Bangalore to Hyderabad Trains
    Train(
      trainNumber: '12794',
      trainName: 'Rayalaseema Express',
      sourceStation: 'SBC',
      destinationStation: 'SC',
      departureTime: '21:45',
      arrivalTime: '08:40',
      duration: '10:55',
      fareByClass: {
        '2A': 1350.0,
        '3A': 980.0,
        'SL': 380.0,
      },
      availableSeats: {
        '2A': 48,
        '3A': 72,
        'SL': 155,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['YPR', 'DMM', 'GTL', 'KRNT'],
    ),

    // Pune to Bangalore Trains
    Train(
      trainNumber: '11302',
      trainName: 'Udyan Express',
      sourceStation: 'PUNE',
      destinationStation: 'SBC',
      departureTime: '19:55',
      arrivalTime: '07:25',
      duration: '11:30',
      fareByClass: {
        '1A': 2200.0,
        '2A': 1450.0,
        '3A': 1050.0,
        'SL': 420.0,
      },
      availableSeats: {
        '1A': 12,
        '2A': 44,
        '3A': 68,
        'SL': 135,
      },
      runningDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      stopsInBetween: ['SUR', 'GDG', 'UBL'],
    ),
  ];

  /// Search trains by source and destination
  static List<Train> searchTrains({
    required String source,
    required String destination,
    DateTime? date,
  }) {
    return trains.where((train) {
      final matchesRoute = train.sourceStation.toUpperCase() == source.toUpperCase() &&
          train.destinationStation.toUpperCase() == destination.toUpperCase();
      
      if (date != null) {
        final dayName = _getDayName(date);
        return matchesRoute && train.runsOnDay(dayName);
      }
      
      return matchesRoute;
    }).toList();
  }

  /// Get train by number
  static Train? getTrainByNumber(String trainNumber) {
    try {
      return trains.firstWhere((train) => train.trainNumber == trainNumber);
    } catch (e) {
      return null;
    }
  }

  /// Filter trains by class
  static List<Train> filterByClass(List<Train> trains, String travelClass) {
    return trains
        .where((train) => train.fareByClass.containsKey(travelClass))
        .toList();
  }

  /// Sort trains by price
  static List<Train> sortByPrice(List<Train> trains, {bool ascending = true}) {
    final sortedTrains = List<Train>.from(trains);
    sortedTrains.sort((a, b) {
      final comparison = a.cheapestFare.compareTo(b.cheapestFare);
      return ascending ? comparison : -comparison;
    });
    return sortedTrains;
  }

  /// Sort trains by duration
  static List<Train> sortByDuration(List<Train> trains, {bool ascending = true}) {
    final sortedTrains = List<Train>.from(trains);
    sortedTrains.sort((a, b) {
      final comparison = a.durationInMinutes.compareTo(b.durationInMinutes);
      return ascending ? comparison : -comparison;
    });
    return sortedTrains;
  }

  /// Sort trains by departure time
  static List<Train> sortByDepartureTime(List<Train> trains, {bool ascending = true}) {
    final sortedTrains = List<Train>.from(trains);
    sortedTrains.sort((a, b) {
      final comparison = a.departureTime.compareTo(b.departureTime);
      return ascending ? comparison : -comparison;
    });
    return sortedTrains;
  }

  /// Helper method to get day name from date
  static String _getDayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}
