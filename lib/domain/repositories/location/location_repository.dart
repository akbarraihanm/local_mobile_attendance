import 'package:hash_micro_test/core/util/resource.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';

abstract class LocationRepository {
  Future<Resource<Iterable<LocationData>>> getLocations();
  Future<Resource<int>> createLocation(LocationData data);
}