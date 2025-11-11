import 'package:flutter/foundation.dart';
import 'package:trainticket/models/train.dart';
import 'package:trainticket/data/mock_trains.dart';

/// Provider for managing train search and filtering
class TrainProvider with ChangeNotifier {
  List<Train> _searchResults = [];
  List<Train> _filteredResults = [];
  bool _isLoading = false;
  String? _errorMessage;
  
  // Filter options
  String _selectedClass = 'All';
  String _sortBy = 'Price'; // Price, Duration, Departure
  bool _sortAscending = true;

  // Getters
  List<Train> get searchResults => _filteredResults;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedClass => _selectedClass;
  String get sortBy => _sortBy;
  bool get sortAscending => _sortAscending;

  /// Search trains by source, destination, and date
  Future<void> searchTrains({
    required String source,
    required String destination,
    DateTime? date,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      _searchResults = MockTrains.searchTrains(
        source: source,
        destination: destination,
        date: date,
      );

      if (_searchResults.isEmpty) {
        _errorMessage = 'No trains found for the selected route.';
      }

      // Apply current filters
      _applyFiltersAndSort();
    } catch (e) {
      _errorMessage = 'Failed to search trains. Please try again.';
      _filteredResults = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Filter by travel class
  void filterByClass(String travelClass) {
    _selectedClass = travelClass;
    _applyFiltersAndSort();
    notifyListeners();
  }

  /// Change sort criteria
  void setSortBy(String sortBy) {
    if (_sortBy == sortBy) {
      // Toggle ascending/descending if same sort criteria
      _sortAscending = !_sortAscending;
    } else {
      _sortBy = sortBy;
      _sortAscending = true;
    }
    _applyFiltersAndSort();
    notifyListeners();
  }

  /// Reset all filters
  void resetFilters() {
    _selectedClass = 'All';
    _sortBy = 'Price';
    _sortAscending = true;
    _applyFiltersAndSort();
    notifyListeners();
  }

  /// Clear search results
  void clearSearch() {
    _searchResults = [];
    _filteredResults = [];
    _errorMessage = null;
    notifyListeners();
  }

  /// Apply filters and sorting to search results
  void _applyFiltersAndSort() {
    List<Train> results = List.from(_searchResults);

    // Apply class filter
    if (_selectedClass != 'All') {
      results = MockTrains.filterByClass(results, _selectedClass);
    }

    // Apply sorting
    switch (_sortBy) {
      case 'Price':
        results = MockTrains.sortByPrice(results, ascending: _sortAscending);
        break;
      case 'Duration':
        results = MockTrains.sortByDuration(results, ascending: _sortAscending);
        break;
      case 'Departure':
        results = MockTrains.sortByDepartureTime(results, ascending: _sortAscending);
        break;
    }

    _filteredResults = results;
  }

  /// Get available classes from search results
  List<String> getAvailableClasses() {
    final classes = <String>{'All'};
    for (var train in _searchResults) {
      classes.addAll(train.fareByClass.keys);
    }
    return classes.toList()..sort();
  }

  /// Get train by number
  Train? getTrainByNumber(String trainNumber) {
    return MockTrains.getTrainByNumber(trainNumber);
  }
}
