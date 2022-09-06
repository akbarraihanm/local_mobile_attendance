import 'package:flutter_test/flutter_test.dart';
import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';
import 'package:hash_micro_test/data/repository/local_data_source/attendance/attendance_data_source.dart';
import 'package:hash_micro_test/data/repository/local_data_source_impl/attendance/attendance_data_source_impl.dart';
import 'package:hash_micro_test/data/service/local_service.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalService extends Mock implements LocalService {}

void main() {
  late MockLocalService service;
  late AttendanceDataSource dataSource;

  setUpAll(() {
    service = MockLocalService();
    dataSource = AttendanceDataSourceImpl(service);
  });

  group('Get Attendance data', () {
    test(
        'Given attendance data source '
        'When get attendance data '
        'Then it should return attendance data', () async {

          when(() => service.getAttendances()).thenAnswer((_) => Future.value([
            AttendanceData(
              latitude: 1.1,
              longitude: 2.2,
              dateTime: DateTime.parse("2000-01-01 00:00:00")
            )
          ]));

          final result = await dataSource.getAttendances();
          expect(result.isEmpty, false);
          expect(result.first.dateTime, DateTime.parse("2000-01-01 00:00:00"));
          expect(result.first.latitude, 1.1);
          expect(result.first.longitude, 2.2);
    });

    test(
        'Given attendance data source '
        'When get attendance data '
        'Then it should return empty data', () async {
        when(() => service.getAttendances()).thenAnswer((_) =>
            Future.value([]));

        final result = await dataSource.getAttendances();
        expect(result.isEmpty, true);
    });
  });

  group('Create Attendance data', () {
    test(
        'Given attendance data source '
        'When create attendance data '
        'Then it should return integer "1" notice that successfully added', () async {

          final payload = AttendanceData(
            dateTime: DateTime.parse("2000-01-01 00:00:00"),
            longitude: 2.2,
            latitude: 1.1
          );

          when(() => service.createAttendance(payload)).thenAnswer((_) =>
              Future.value(1));

          final result = await dataSource.createAttendance(payload);
          expect(result, 1);
    });
  });
}