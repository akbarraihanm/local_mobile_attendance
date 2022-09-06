import 'package:hive/hive.dart';
part 'location_data.g.dart';

@HiveType(typeId: 0)
class LocationData {
  @HiveField(0)
  String? address;
  @HiveField(1)
  dynamic latitude;
  @HiveField(2)
  dynamic longitude;

  LocationData({
    this.address,
    this.latitude,
    this.longitude
  });
}