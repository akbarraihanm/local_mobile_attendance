import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';

abstract class AttendanceDataSource {
  Future<Iterable<AttendanceData>> getAttendances();
  Future<int> createAttendance(AttendanceData data);
}