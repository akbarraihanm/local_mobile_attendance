import 'package:hash_micro_test/core/util/resource.dart';
import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';
import 'package:hash_micro_test/domain/repositories/attendance/attendance_repository.dart';

class AttendanceUseCase {
  final AttendanceRepository repository;

  AttendanceUseCase(this.repository);

  Future<Resource<Iterable<AttendanceData>>> getAttendances() {
    return repository.getAttendances();
  }

  Future<Resource<int>> createAttendance(AttendanceData data) {
    return repository.createAttendance(data);
  }
}