import 'package:flutter/material.dart';
import 'package:trainticket/constants/colors.dart';
import 'package:trainticket/constants/strings.dart';

class PopularRoutesWidget extends StatelessWidget {
  const PopularRoutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from provider
    final popularRoutes = [
      {'from': 'Mumbai', 'to': 'Delhi'},
      {'from': 'Bangalore', 'to': 'Chennai'},
      {'from': 'Kolkata', 'to': 'Hyderabad'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppStrings.popularRoutes,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: popularRoutes.length,
          itemBuilder: (context, index) {
            final route = popularRoutes[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.train,
                  color: AppColors.primary,
                ),
                title: Text(route['from']!),
                trailing: Text(route['to']!),
                onTap: () {
                  // TODO: Implement route selection
                },
              ),
            );
          },
        ),
      ],
    );
  }
}