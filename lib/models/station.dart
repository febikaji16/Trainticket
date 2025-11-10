/// Model class for Railway Station
class Station {
  final String stationCode;
  final String stationName;
  final String city;
  final String state;

  Station({
    required this.stationCode,
    required this.stationName,
    required this.city,
    required this.state,
  });

  // Display name (Code - Name)
  String get displayName => '$stationCode - $stationName';

  // Full display (Code - Name, City)
  String get fullDisplayName => '$stationCode - $stationName, $city';

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'stationCode': stationCode,
      'stationName': stationName,
      'city': city,
      'state': state,
    };
  }

  // Create from JSON
  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      stationCode: json['stationCode'],
      stationName: json['stationName'],
      city: json['city'],
      state: json['state'],
    );
  }

  @override
  String toString() => displayName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Station &&
          runtimeType == other.runtimeType &&
          stationCode == other.stationCode;

  @override
  int get hashCode => stationCode.hashCode;
}
