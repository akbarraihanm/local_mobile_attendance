import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hash_micro_test/data/repository/local_data_source/location/location_data_source.dart';
import 'package:hash_micro_test/data/service/local_service.dart';

class LocationDataSourceImpl implements LocationDataSource {

  final LocalService service;

  LocationDataSourceImpl(this.service);

  @override
  Future<int> createLocation(LocationData data) {
    return service.createLocation(data);
  }

  @override
  Future<Iterable<LocationData>> getLocations() {
    return service.getLocationList();
  }

}