/// Model class for Train information
class Train {
  final String trainNumber;
  final String trainName;
  final String sourceStation;
  final String destinationStation;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final Map<String, double> fareByClass; // Class -> Fare mapping
  final Map<String, int> availableSeats; // Class -> Available seats
  final List<String> runningDays; // Days when train runs
  final List<String> stopsInBetween; // Intermediate stations

  Train({
    required this.trainNumber,
    required this.trainName,
    required this.sourceStation,
    required this.destinationStation,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.fareByClass,
    required this.availableSeats,
    required this.runningDays,
    this.stopsInBetween = const [],
  });

  // Calculate total journey time in minutes
  int get durationInMinutes {
    final parts = duration.split(':');
    return int.parse(parts[0]) * 60 + int.parse(parts[1]);
  }

  // Check if train runs on a specific day
  bool runsOnDay(String day) {
    return runningDays.contains(day);
  }

  // Get cheapest fare
  double get cheapestFare {
    return fareByClass.values.reduce((a, b) => a < b ? a : b);
  }

  // Convert to JSON (for future API integration)
  Map<String, dynamic> toJson() {
    return {
      'trainNumber': trainNumber,
      'trainName': trainName,
      'sourceStation': sourceStation,
      'destinationStation': destinationStation,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'duration': duration,
      'fareByClass': fareByClass,
      'availableSeats': availableSeats,
      'runningDays': runningDays,
      'stopsInBetween': stopsInBetween,
    };
  }

  // Create from JSON
  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      trainNumber: json['trainNumber'],
      trainName: json['trainName'],
      sourceStation: json['sourceStation'],
      destinationStation: json['destinationStation'],
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      duration: json['duration'],
      fareByClass: Map<String, double>.from(json['fareByClass']),
      availableSeats: Map<String, int>.from(json['availableSeats']),
      runningDays: List<String>.from(json['runningDays']),
      stopsInBetween: List<String>.from(json['stopsInBetween'] ?? []),
    );
  }
}
