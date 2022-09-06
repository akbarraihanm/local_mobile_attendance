import 'package:flutter_test/flutter_test.dart';
import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';

void main() {
  test(
      'Given attendance data '
      'When initialized '
      'Then it should return correct data', () {

        final data = AttendanceData(
          dateTime: DateTime.parse("2000-01-01 00:00:00"),
          latitude: 0.0,
          longitude: 0.0
        );

        expect(data.dateTime, DateTime.parse("2000-01-01 00:00:00"));
        expect(data.latitude, 0.0);
        expect(data.longitude, 0.0);
  });
}