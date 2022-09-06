import 'package:flutter_test/flutter_test.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';

void main() {
  test(
      'Given location data '
      'When initialized '
      'Then it should return correct data', () {

        final location = LocationData(
          longitude: 0.0,
          latitude: 0.0,
          address: "address"
        );

        expect(location.address, "address");
        expect(location.latitude, 0.0);
        expect(location.longitude, 0.0);
  });
}