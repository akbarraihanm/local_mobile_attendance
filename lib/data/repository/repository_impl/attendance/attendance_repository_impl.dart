import 'package:hash_micro_test/core/util/resource.dart';
import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';
import 'package:hash_micro_test/data/repository/local_data_source/attendance/attendance_data_source.dart';
import 'package:hash_micro_test/domain/repositories/attendance/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceDataSource dataSource;

  AttendanceRepositoryImpl(this.dataSource);

  @override
  Future<Resource<int>> createAttendance(AttendanceData data) async {
    try {
      final result = await dataSource.createAttendance(data);
      return Resource.success(result);
    } catch(ex) {
      return Resource.error(ex.toString());
    }
  }

  @override
  Future<Resource<Iterable<AttendanceData>>> getAttendances() async {
    try {
      final result = await dataSource.getAttendances();
      return Resource.success(result);
    } catch(ex) {
      return Resource.error(ex.toString());
    }
  }
}