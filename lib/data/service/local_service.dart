import 'package:hash_micro_test/core/config/const.dart';
import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hive/hive.dart';

class LocalService {

  ///Location
  Future<Iterable<LocationData>> getLocationList() async {
    Iterable<LocationData> result;
    try {
      result = Hive.box<LocationData>(Const.locationBox)
          .values;
    } catch (ex) {
      throw Exception("An Error Occurred");
    }
    return result;
  }

  Future<int> createLocation(LocationData data) async {
    try {
      final box = Hive.box<LocationData>(Const.locationBox);
      box.add(data);
    } catch (ex) {
      throw Exception("An Error Occurred");
    }
    return 1;
  }

  //==========================================================================//

  ///Attendance
  Future<Iterable<AttendanceData>> getAttendances() async {
    Iterable<AttendanceData> result;
    try {
      result = Hive.box<AttendanceData>(Const.attendanceBox).values;
    } catch (ex) {
      throw Exception("An Error Occurred");
    }
    return result;
  }

  Future<int> createAttendance(AttendanceData data) async {
    try {
      final box = Hive.box<AttendanceData>(Const.attendanceBox);
      box.add(data);
    } catch (ex) {
      throw Exception("An Error Occurred");
    }
    return 1;
  }
  //==========================================================================//
}