import 'package:hash_micro_test/core/util/resource.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hash_micro_test/domain/repositories/location/location_repository.dart';

class LocationUseCase {
  final LocationRepository repository;

  LocationUseCase(this.repository);

  Future<Resource<Iterable<LocationData>>> getLocations() {
    return repository.getLocations();
  }

  Future<Resource<int>> createLocation(LocationData data) {
    return repository.createLocation(data);
  }
}