class User {
  final String id;
  final String email;
  final String name;
  final String? phoneNumber;
  final String? address;
  final DateTime createdAt;
  final List<String> bookedTickets;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.address,
    required this.createdAt,
    this.bookedTickets = const [],
  });

  User copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    List<String>? bookedTickets,
  }) {
    return User(
      id: id,
      email: email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      createdAt: createdAt,
      bookedTickets: bookedTickets ?? this.bookedTickets,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'bookedTickets': bookedTickets,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      createdAt: DateTime.parse(json['createdAt']),
      bookedTickets: List<String>.from(json['bookedTickets'] ?? []),
    );
  }
}