import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hash_micro_test/core/util/resource.dart';
import 'package:hash_micro_test/data/models/attendance_data/attendance_data.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/domain/repositories/attendance/attendance_repository.dart';
import 'package:hash_micro_test/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:hash_micro_test/presentation/blocs/attendance/attendance_event.dart';
import 'package:hash_micro_test/presentation/blocs/attendance/attendance_state.dart';
import 'package:mocktail/mocktail.dart';

class MockAttendanceRepository extends Mock implements AttendanceRepository {}

void main() {
  late MockAttendanceRepository repository;

  setUpAll(() {
    repository = MockAttendanceRepository();

    DIObject.init();
    GetIt.I.unregister<AttendanceRepository>();
    GetIt.I.registerLazySingleton<AttendanceRepository>(() => repository);

    registerFallbackValue(AttendanceData(
        latitude: 0.0,
        longitude: 0.0,
        dateTime: DateTime.now()
    ));
  });

  group('AttendanceBloc - GetListAttendanceEvent test', () {
    blocTest(
      'Given attendance bloc '
      'When GetListAttendanceEvent getting error '
      'Then it should return ShowErrorAttendanceState',
      build: () {
        when(() => DIObject.attendanceBloc.useCase.getAttendances())
            .thenAnswer((_) => Future.value(Resource.error("")));
        return DIObject.attendanceBloc;
      },
      wait: const Duration(seconds: 1),
      act: (AttendanceBloc bloc) => bloc.add(GetListAttendanceEvent()),
      expect: () => [isA<ShowErrorAttendanceState>()],
    );

    blocTest(
      'Given attendance bloc '
      'When GetListAttendanceEvent success '
      'Then it should return InitAttendanceState',
      build: () {
        when(() => DIObject.attendanceBloc.useCase.getAttendances())
            .thenAnswer((_) => Future.value(Resource.success([
              AttendanceData(
                longitude: 2.2, latitude: 1.1,
                dateTime: DateTime.now()
              )
        ])));
        return DIObject.attendanceBloc;
      },
      wait: const Duration(seconds: 1),
      act: (AttendanceBloc bloc) => bloc.add(GetListAttendanceEvent()),
      expect: () => [isA<InitAttendanceState>()],
    );
  });

  // group('Attendance Bloc - CreateAttendanceEvent test', () {
  //
  //   blocTest(
  //     'Given attendance bloc '
  //     'When CreateAttendanceEvent error '
  //     'Then it should call ShowErrorAttendanceState',
  //     build: () {
  //       DIObject.attendanceBloc.latitude = 0.0;
  //       DIObject.attendanceBloc.longitude = 0.0;
  //       when(() => DIObject.attendanceBloc.useCase.createAttendance(any()))
  //           .thenAnswer((_) => Future.value(Resource.error("")));
  //       return DIObject.attendanceBloc;
  //     },
  //     wait: const Duration(seconds: 1),
  //     act: (AttendanceBloc bloc) => bloc.add(CreateAttendanceEvent()),
  //     expect: () => [isA<ShowErrorAttendanceState>()]
  //   );
  //
  //   blocTest(
  //       'Given attendance bloc '
  //           'When CreateAttendanceEvent error '
  //           'Then it should call SuccessCreateAttendanceState',
  //       build: () {
  //         DIObject.attendanceBloc.latitude = 0.0;
  //         DIObject.attendanceBloc.longitude = 0.0;
  //         when(() => DIObject.attendanceBloc.useCase.createAttendance(any()))
  //             .thenAnswer((_) => Future.value(Resource.success(1)));
  //         return DIObject.attendanceBloc;
  //       },
  //       wait: const Duration(seconds: 1),
  //       act: (AttendanceBloc bloc) => bloc.add(CreateAttendanceEvent()),
  //       expect: () => [isA<SuccessCreateAttendanceState>()]
  //   );
  // });
}