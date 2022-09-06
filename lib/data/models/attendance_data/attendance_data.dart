import 'package:hive/hive.dart';
part 'attendance_data.g.dart';

@HiveType(typeId: 1)
class AttendanceData {

  @HiveField(0)
  DateTime? dateTime;
  @HiveField(1)
  dynamic latitude;
  @HiveField(2)
  dynamic longitude;

  AttendanceData({this.dateTime, this.latitude, this.longitude});
}