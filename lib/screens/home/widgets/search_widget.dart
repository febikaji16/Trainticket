import 'package:flutter/material.dart';
import 'package:trainticket/constants/colors.dart';
import 'package:trainticket/constants/strings.dart';
import 'package:trainticket/data/mock_stations.dart';

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

  void _showStationPicker(
    BuildContext context,
    TextEditingController controller,
    String title,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: MockStations.stations.length,
                  itemBuilder: (context, index) {
                    final station = MockStations.stations[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Text(
                          station.stationCode,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      title: Text(station.stationName),
                      subtitle: Text('${station.city}, ${station.state}'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        controller.text = station.displayName;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

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
              readOnly: true,
              onTap: () => _showStationPicker(
                context,
                fromController,
                'Select Source Station',
              ),
              decoration: const InputDecoration(
                labelText: AppStrings.from,
                prefixIcon: Icon(Icons.location_on),
                suffixIcon: Icon(Icons.arrow_drop_down),
                hintText: AppStrings.searchHint,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: toController,
              readOnly: true,
              onTap: () => _showStationPicker(
                context,
                toController,
                'Select Destination Station',
              ),
              decoration: const InputDecoration(
                labelText: AppStrings.to,
                prefixIcon: Icon(Icons.location_on),
                suffixIcon: Icon(Icons.arrow_drop_down),
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