import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainticket/providers/train_provider.dart';

/// Widget for filtering and sorting train search results
class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter & Sort',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<TrainProvider>(context, listen: false)
                      .resetFilters();
                },
                child: const Text('Reset'),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          
          // Filter by class
          const Text(
            'Travel Class',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Consumer<TrainProvider>(
            builder: (context, provider, child) {
              final classes = provider.getAvailableClasses();
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: classes.map((classType) {
                  final isSelected = provider.selectedClass == classType;
                  return FilterChip(
                    label: Text(classType),
                    selected: isSelected,
                    onSelected: (selected) {
                      provider.filterByClass(classType);
                    },
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 24),
          
          // Sort options
          const Text(
            'Sort By',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Consumer<TrainProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  _buildSortOption(
                    context: context,
                    title: 'Price',
                    subtitle: 'Low to High / High to Low',
                    isSelected: provider.sortBy == 'Price',
                    onTap: () => provider.setSortBy('Price'),
                  ),
                  _buildSortOption(
                    context: context,
                    title: 'Duration',
                    subtitle: 'Shortest to Longest',
                    isSelected: provider.sortBy == 'Duration',
                    onTap: () => provider.setSortBy('Duration'),
                  ),
                  _buildSortOption(
                    context: context,
                    title: 'Departure Time',
                    subtitle: 'Earliest to Latest',
                    isSelected: provider.sortBy == 'Departure',
                    onTap: () => provider.setSortBy('Departure'),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          
          // Apply button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Radio<bool>(
        value: true,
        groupValue: isSelected,
        onChanged: (value) => onTap(),
      ),
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
