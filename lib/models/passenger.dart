/// Model class for Passenger information
class Passenger {
  final String name;
  final int age;
  final String gender;
  final String? seatPreference; // Window, Aisle, etc.
  final String? berthPreference; // Lower, Middle, Upper

  Passenger({
    required this.name,
    required this.age,
    required this.gender,
    this.seatPreference,
    this.berthPreference,
  });

  // Validation
  bool get isValid {
    return name.isNotEmpty && age > 0 && age <= 120 && gender.isNotEmpty;
  }

  // Determine passenger category
  String get category {
    if (age < 5) return 'Infant';
    if (age < 12) return 'Child';
    if (age >= 60) return 'Senior Citizen';
    return 'Adult';
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'seatPreference': seatPreference,
      'berthPreference': berthPreference,
    };
  }

  // Create from JSON
  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      seatPreference: json['seatPreference'],
      berthPreference: json['berthPreference'],
    );
  }

  // Copy with method for modifications
  Passenger copyWith({
    String? name,
    int? age,
    String? gender,
    String? seatPreference,
    String? berthPreference,
  }) {
    return Passenger(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      seatPreference: seatPreference ?? this.seatPreference,
      berthPreference: berthPreference ?? this.berthPreference,
    );
  }
}
