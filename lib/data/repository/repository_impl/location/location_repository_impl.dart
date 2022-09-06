import 'package:hash_micro_test/core/util/resource.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hash_micro_test/data/repository/local_data_source/location/location_data_source.dart';
import 'package:hash_micro_test/domain/repositories/location/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {

  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Resource<int>> createLocation(LocationData data) async {
    try {
      final result = await dataSource.createLocation(data);
      return Resource.success(result);
    } catch (ex) {
      return Resource.error(ex.toString());
    }
  }

  @override
  Future<Resource<Iterable<LocationData>>> getLocations() async {
    try {
      final result = await dataSource.getLocations();
      return Resource.success(result);
    } catch(ex) {
      return Resource.error(ex.toString());
    }
  }

}