import 'package:hash_micro_test/data/models/location/location_data.dart';

abstract class LocationDataSource {
  Future<Iterable<LocationData>> getLocations();
  Future<int> createLocation(LocationData data);
}