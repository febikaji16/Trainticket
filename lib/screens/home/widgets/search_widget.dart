import 'package:flutter/material.dart';
import 'package:trainticket/constants/colors.dart';
import 'package:trainticket/constants/strings.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController fromController;
  final TextEditingController toController;
  final DateTime selectedDate;
  final Function() onDateTap;
  final Function() onSearchTap;

  const SearchWidget({
    super.key,
    required this.fromController,
    required this.toController,
    required this.selectedDate,
    required this.onDateTap,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: fromController,
              decoration: const InputDecoration(
                labelText: AppStrings.from,
                prefixIcon: Icon(Icons.train),
                hintText: AppStrings.searchHint,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: toController,
              decoration: const InputDecoration(
                labelText: AppStrings.to,
                prefixIcon: Icon(Icons.train),
                hintText: AppStrings.searchHint,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: onDateTap,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: AppStrings.date,
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  selectedDate.toString().split(' ')[0],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onSearchTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(AppStrings.searchTrains),
            ),
          ],
        ),
      ),
    );
  }
}