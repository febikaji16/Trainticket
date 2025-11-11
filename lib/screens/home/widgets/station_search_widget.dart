import 'package:flutter/material.dart';
import 'package:trainticket/constants/colors.dart';
import 'package:trainticket/constants/strings.dart';
import 'package:trainticket/data/mock_stations.dart';
import 'package:trainticket/models/station.dart';

class SearchWidget extends StatelessWidget {
  final Station? fromStation;
  final Station? toStation;
  final DateTime selectedDate;
  final Function() onDateTap;
  final Function() onSearchTap;
  final Function(Station) onFromStationSelected;
  final Function(Station) onToStationSelected;

  const SearchWidget({
    super.key,
    this.fromStation,
    this.toStation,
    required this.selectedDate,
    required this.onDateTap,
    required this.onSearchTap,
    required this.onFromStationSelected,
    required this.onToStationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Autocomplete<Station>(
              displayStringForOption: (station) => station.fullDisplayName,
              initialValue: fromStation != null 
                  ? TextEditingValue(text: fromStation!.fullDisplayName)
                  : null,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<Station>.empty();
                }
                return MockStations.stations.where((station) {
                  final searchText = textEditingValue.text.toLowerCase();
                  return station.stationCode.toLowerCase().contains(searchText) ||
                      station.stationName.toLowerCase().contains(searchText) ||
                      station.city.toLowerCase().contains(searchText);
                });
              },
              onSelected: onFromStationSelected,
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: AppStrings.from,
                    prefixIcon: Icon(Icons.train),
                    hintText: AppStrings.searchHint,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Autocomplete<Station>(
              displayStringForOption: (station) => station.fullDisplayName,
              initialValue: toStation != null 
                  ? TextEditingValue(text: toStation!.fullDisplayName)
                  : null,
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<Station>.empty();
                }
                return MockStations.stations.where((station) {
                  final searchText = textEditingValue.text.toLowerCase();
                  return station.stationCode.toLowerCase().contains(searchText) ||
                      station.stationName.toLowerCase().contains(searchText) ||
                      station.city.toLowerCase().contains(searchText);
                });
              },
              onSelected: onToStationSelected,
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: AppStrings.to,
                    prefixIcon: Icon(Icons.train),
                    hintText: AppStrings.searchHint,
                  ),
                );
              },
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