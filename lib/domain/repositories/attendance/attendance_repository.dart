import 'package:hash_micro_test/core/util/resource.dart';
import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';

abstract class AttendanceRepository {
  Future<Resource<Iterable<AttendanceData>>> getAttendances();
  Future<Resource<int>> createAttendance(AttendanceData data);
}