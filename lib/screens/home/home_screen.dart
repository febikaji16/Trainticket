import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trainticket/constants/strings.dart';
import 'package:trainticket/models/station.dart';
import 'package:trainticket/screens/home/widgets/app_drawer.dart';

import 'package:trainticket/screens/home/widgets/popular_routes_widget.dart';
import 'package:trainticket/screens/home/widgets/station_search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Station? _fromStation;
  Station? _toStation;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _onSearch() {
    // Validate input
    if (_fromStation == null || _toStation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both source and destination stations'),
        ),
      );
      return;
    }
    
    // Navigate to search results with query parameters
    context.pushNamed('search', extra: {
      'from': _fromStation!.stationCode,
      'to': _toStation!.stationCode,
      'date': _selectedDate.toString(),
    });
  }

  void _onFromStationSelected(Station station) {
    setState(() {
      _fromStation = station;
    });
  }

  void _onToStationSelected(Station station) {
    setState(() {
      _toStation = station;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchWidget(
                fromStation: _fromStation,
                toStation: _toStation,
                selectedDate: _selectedDate,
                onDateTap: () => _selectDate(context),
                onSearchTap: _onSearch,
                onFromStationSelected: _onFromStationSelected,
                onToStationSelected: _onToStationSelected,
              ),
            ),
            const PopularRoutesWidget(),
          ],
        ),
      ),

    );
  }
}