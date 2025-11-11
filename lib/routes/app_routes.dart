import 'package:flutter/material.dart';
import 'package:trainticket/screens/home/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String search = '/search';
  static const String trainDetails = '/train-details';
  static const String booking = '/booking';
  static const String payment = '/payment';
  static const String confirmation = '/confirmation';
  static const String myBookings = '/my-bookings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case search:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // Will be replaced with SearchScreen
        );
      case trainDetails:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // Will be replaced with TrainDetailsScreen
        );
      case booking:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // Will be replaced with BookingScreen
        );
      case payment:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // Will be replaced with PaymentScreen
        );
      case confirmation:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // Will be replaced with ConfirmationScreen
        );
      case myBookings:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(), // Will be replaced with MyBookingsScreen
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}