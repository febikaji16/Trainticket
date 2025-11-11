import 'package:flutter/material.dart';
import 'package:trainticket/constants/strings.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: AppStrings.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_number),
          label: AppStrings.myBookings,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: AppStrings.profile,
        ),
      ],
    );
  }
}