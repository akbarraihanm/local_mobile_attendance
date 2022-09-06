import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';
import 'package:hash_micro_test/data/repository/local_data_source/attendance/attendance_data_source.dart';
import 'package:hash_micro_test/data/service/local_service.dart';

class AttendanceDataSourceImpl implements AttendanceDataSource {
  final LocalService service;

  AttendanceDataSourceImpl(this.service);

  @override
  Future<int> createAttendance(AttendanceData data) {
    return service.createAttendance(data);
  }

  @override
  Future<Iterable<AttendanceData>> getAttendances() {
    return service.getAttendances();
  }
}