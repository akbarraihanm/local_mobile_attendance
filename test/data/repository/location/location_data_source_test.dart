import 'package:flutter_test/flutter_test.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hash_micro_test/data/repository/local_data_source/location/location_data_source.dart';
import 'package:hash_micro_test/data/repository/local_data_source_impl/location/location_data_source_impl.dart';
import 'package:hash_micro_test/data/service/local_service.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalService extends Mock implements LocalService {}

void main() {
  late MockLocalService service;
  late LocationDataSource dataSource;

  setUpAll(() {
    service = MockLocalService();
    dataSource = LocationDataSourceImpl(service);
  });

  group('Get Location data', () {
    test(
        'Given location data source '
        'When get location data '
        'Then it should return location data', () async {

          when(() => service.getLocationList()).thenAnswer((_) =>
          Future.value([
            LocationData(
              address: "address",
              latitude: 0.0,
              longitude: 0.0
            )
          ]));

          final result = await dataSource.getLocations();
          expect(result.isNotEmpty, true);
    });

    test(
        'Given location data source '
        'When get location data '
        'Then it should return empty data', () async {

          when(() => service.getLocationList()).thenAnswer((_) =>
              Future.value([]));

          final result = await dataSource.getLocations();
          expect(result.isEmpty, true);
    });
  });

  group('Create Location data', () {
    test(
        'Given local service '
        'When create location data '
        'Then it should return integer "1" notice that successfully added', () async{

          final payload = LocationData(
            address: "address",
            latitude: 0.0,
            longitude: 0.0
          );

          when(() => service.createLocation(payload)).thenAnswer((_) =>
              Future.value(1));

          final result = await dataSource.createLocation(payload);
          expect(result, 1);
    });
  });
}