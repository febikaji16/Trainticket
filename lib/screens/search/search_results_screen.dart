import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainticket/providers/train_provider.dart';
import 'package:trainticket/screens/search/widgets/train_card.dart';
import 'package:trainticket/screens/search/widgets/filter_widget.dart';

/// Screen displaying train search results with filtering and sorting options
class SearchResultsScreen extends StatelessWidget {
  final String sourceStation;
  final String destinationStation;
  final DateTime journeyDate;

  const SearchResultsScreen({
    super.key,
    required this.sourceStation,
    required this.destinationStation,
    required this.journeyDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$sourceStation → $destinationStation',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              _formatDate(journeyDate),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: Consumer<TrainProvider>(
        builder: (context, trainProvider, child) {
          if (trainProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Searching trains...'),
                ],
              ),
            );
          }

          if (trainProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    trainProvider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _searchAgain(context),
                    child: const Text('Search Again'),
                  ),
                ],
              ),
            );
          }

          final trains = trainProvider.searchResults;

          if (trains.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.train, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No trains found',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('Try searching for a different route'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Search'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Sort and filter summary bar
              _buildFilterSummary(context, trainProvider),
              
              // Train list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: trains.length,
                  itemBuilder: (context, index) {
                    return TrainCard(
                      train: trains[index],
                      onTap: () => _onTrainTap(context, trains[index]),
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

  Widget _buildFilterSummary(BuildContext context, TrainProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[200],
      child: Row(
        children: [
          Text(
            '${provider.searchResults.length} trains found',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          if (provider.selectedClass != 'All')
            Chip(
              label: Text(provider.selectedClass),
              onDeleted: () => provider.filterByClass('All'),
              deleteIconColor: Colors.red,
            ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            icon: Row(
              children: [
                Text('Sort: ${provider.sortBy}'),
                Icon(provider.sortAscending
                    ? Icons.arrow_upward
                    : Icons.arrow_downward),
              ],
            ),
            onSelected: (value) => provider.setSortBy(value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Price', child: Text('Price')),
              const PopupMenuItem(value: 'Duration', child: Text('Duration')),
              const PopupMenuItem(value: 'Departure', child: Text('Departure Time')),
            ],
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const FilterWidget(),
    );
  }

  void _searchAgain(BuildContext context) {
    final provider = Provider.of<TrainProvider>(context, listen: false);
    provider.searchTrains(
      source: sourceStation,
      destination: destinationStation,
      date: journeyDate,
    );
  }

  void _onTrainTap(BuildContext context, train) {
    // TODO: Navigate to train details screen (Developer 3's task)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: ${train.trainName}'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}
