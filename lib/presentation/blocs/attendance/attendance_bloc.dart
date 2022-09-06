import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hash_micro_test/core/common/datetime_formatter.dart';
import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/presentation/blocs/attendance/attendance_event.dart';
import 'package:hash_micro_test/presentation/blocs/attendance/attendance_state.dart';

import '../../../domain/use_cases/attendance/attendance_use_case.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {

  late AttendanceUseCase _useCase;
  Position? position;
  Iterable<AttendanceData> _attendances = [];
  AttendanceData? data;
  String _dateNow = "";

  AttendanceUseCase get useCase => _useCase;
  Iterable<AttendanceData> get attendances => _attendances;

  ///Create Attendance
  dynamic latitude;
  dynamic longitude;

  AttendanceBloc(): super(InitAttendanceState()) {
    _useCase = AttendanceUseCase(DIObject.attendanceRepository);

    on<ChangeAttendanceStateEvent>((event, emit) =>
        emit(InitAttendanceState()));

    on<GetListAttendanceEvent>((event, emit) async {
      final result = await useCase.getAttendances();

      await Future.delayed(const Duration(seconds: 1), () {
        if (result.message != null) {
          emit(ShowErrorAttendanceState(result.message ?? ""));
        } else {
          _attendances = result.data ?? [];
          _dateNow = DateTimeFormatter.formatTime(
            dateTime: DateTime.now(), dateFormat: "yyyy-MM-dd"
          );
          for (var element in _attendances) {
            String elementNow = DateTimeFormatter.formatTime(
              dateTime: element.dateTime, dateFormat: "yyyy-MM-dd"
            );
            if (_dateNow == elementNow) data = element;
          }
          emit(InitAttendanceState());
        }
      });
    });

    on<CreateAttendanceEvent>((event, emit) async {
      final payload = AttendanceData(
        dateTime: DateTime.now(),
        latitude: latitude,
        longitude: longitude
      );

      final distance = Geolocator.distanceBetween(
        latitude, longitude, event.pinLatitude, event.pinLongitude,
      ).round();

      if (distance > 50) {
        emit(ShowErrorAttendanceState("Too far from checkpoint"));
      } else {
        final result = await useCase.createAttendance(payload);

        await Future.delayed(const Duration(seconds: 1), () {
          if (result.message != null) {
            emit(ShowErrorAttendanceState(result.message ?? ""));
          } else {
            emit(SuccessCreateAttendanceState("Attendance has been added"));
          }
        });
      }
    });
  }
}