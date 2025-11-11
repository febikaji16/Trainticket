import 'package:trainticket/models/station.dart';

/// Hardcoded list of railway stations across India
class MockStations {
  static final List<Station> stations = [
    // Major Cities - North India
    Station(
      stationCode: 'NDLS',
      stationName: 'New Delhi',
      city: 'Delhi',
      state: 'Delhi',
    ),
    Station(
      stationCode: 'DEE',
      stationName: 'Delhi Sarai Rohilla',
      city: 'Delhi',
      state: 'Delhi',
    ),
    Station(
      stationCode: 'DLI',
      stationName: 'Old Delhi',
      city: 'Delhi',
      state: 'Delhi',
    ),
    
    // Mumbai Stations
    Station(
      stationCode: 'CSMT',
      stationName: 'Chhatrapati Shivaji Maharaj Terminus',
      city: 'Mumbai',
      state: 'Maharashtra',
    ),
    Station(
      stationCode: 'BCT',
      stationName: 'Mumbai Central',
      city: 'Mumbai',
      state: 'Maharashtra',
    ),
    Station(
      stationCode: 'LTT',
      stationName: 'Lokmanya Tilak Terminus',
      city: 'Mumbai',
      state: 'Maharashtra',
    ),
    
    // Bangalore
    Station(
      stationCode: 'SBC',
      stationName: 'Bangalore City Junction',
      city: 'Bangalore',
      state: 'Karnataka',
    ),
    Station(
      stationCode: 'YPR',
      stationName: 'Yesvantpur Junction',
      city: 'Bangalore',
      state: 'Karnataka',
    ),
    
    // Chennai
    Station(
      stationCode: 'MAS',
      stationName: 'Chennai Central',
      city: 'Chennai',
      state: 'Tamil Nadu',
    ),
    Station(
      stationCode: 'MS',
      stationName: 'Chennai Egmore',
      city: 'Chennai',
      state: 'Tamil Nadu',
    ),
    
    // Kolkata
    Station(
      stationCode: 'HWH',
      stationName: 'Howrah Junction',
      city: 'Kolkata',
      state: 'West Bengal',
    ),
    Station(
      stationCode: 'SDAH',
      stationName: 'Sealdah',
      city: 'Kolkata',
      state: 'West Bengal',
    ),
    
    // Hyderabad
    Station(
      stationCode: 'SC',
      stationName: 'Secunderabad Junction',
      city: 'Hyderabad',
      state: 'Telangana',
    ),
    Station(
      stationCode: 'HYB',
      stationName: 'Hyderabad Deccan',
      city: 'Hyderabad',
      state: 'Telangana',
    ),
    
    // Pune
    Station(
      stationCode: 'PUNE',
      stationName: 'Pune Junction',
      city: 'Pune',
      state: 'Maharashtra',
    ),
    
    // Ahmedabad
    Station(
      stationCode: 'ADI',
      stationName: 'Ahmedabad Junction',
      city: 'Ahmedabad',
      state: 'Gujarat',
    ),
    
    // Jaipur
    Station(
      stationCode: 'JP',
      stationName: 'Jaipur Junction',
      city: 'Jaipur',
      state: 'Rajasthan',
    ),
    
    // Lucknow
    Station(
      stationCode: 'LKO',
      stationName: 'Lucknow Charbagh',
      city: 'Lucknow',
      state: 'Uttar Pradesh',
    ),
    
    // Kanpur
    Station(
      stationCode: 'CNB',
      stationName: 'Kanpur Central',
      city: 'Kanpur',
      state: 'Uttar Pradesh',
    ),
    
    // Nagpur
    Station(
      stationCode: 'NGP',
      stationName: 'Nagpur Junction',
      city: 'Nagpur',
      state: 'Maharashtra',
    ),
    
    // Bhopal
    Station(
      stationCode: 'BPL',
      stationName: 'Bhopal Junction',
      city: 'Bhopal',
      state: 'Madhya Pradesh',
    ),
    
    // Indore
    Station(
      stationCode: 'INDB',
      stationName: 'Indore Junction',
      city: 'Indore',
      state: 'Madhya Pradesh',
    ),
    
    // Chandigarh
    Station(
      stationCode: 'CDG',
      stationName: 'Chandigarh',
      city: 'Chandigarh',
      state: 'Chandigarh',
    ),
    
    // Patna
    Station(
      stationCode: 'PNBE',
      stationName: 'Patna Junction',
      city: 'Patna',
      state: 'Bihar',
    ),
    
    // Varanasi
    Station(
      stationCode: 'BSB',
      stationName: 'Varanasi Junction',
      city: 'Varanasi',
      state: 'Uttar Pradesh',
    ),
  ];

  /// Get station by code
  static Station? getStationByCode(String code) {
    try {
      return stations.firstWhere(
        (station) => station.stationCode.toUpperCase() == code.toUpperCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Search stations by name or code
  static List<Station> searchStations(String query) {
    if (query.isEmpty) return stations;
    
    final lowercaseQuery = query.toLowerCase();
    return stations.where((station) {
      return station.stationCode.toLowerCase().contains(lowercaseQuery) ||
          station.stationName.toLowerCase().contains(lowercaseQuery) ||
          station.city.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  /// Get stations by state
  static List<Station> getStationsByState(String state) {
    return stations
        .where((station) =>
            station.state.toLowerCase() == state.toLowerCase())
        .toList();
  }
}
