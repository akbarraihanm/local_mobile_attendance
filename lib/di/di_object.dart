import 'package:get_it/get_it.dart';
import 'package:hash_micro_test/data/repository/local_data_source_impl/attendance/attendance_data_source_impl.dart';
import 'package:hash_micro_test/data/repository/local_data_source_impl/location/location_data_source_impl.dart';
import 'package:hash_micro_test/data/repository/repository_impl/attendance/attendance_repository_impl.dart';
import 'package:hash_micro_test/data/repository/repository_impl/location/location_repository_impl.dart';
import 'package:hash_micro_test/data/service/local_service.dart';
import 'package:hash_micro_test/domain/repositories/attendance/attendance_repository.dart';
import 'package:hash_micro_test/domain/repositories/location/location_repository.dart';
import 'package:hash_micro_test/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:hash_micro_test/presentation/blocs/dashboard/dashboard_bloc.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_bloc.dart';

class DIObject {
  static void init() {
    final service = LocalService();

    ///Instance local data sources here
    final locationLocal = LocationDataSourceImpl(service);
    final attendanceLocal = AttendanceDataSourceImpl(service);
    //========================================================================//

    ///Instance repositories here
    final locationRepo = LocationRepositoryImpl(locationLocal);
    final attendanceRepo = AttendanceRepositoryImpl(attendanceLocal);
    //========================================================================//

    ///Inject the repositories
    GetIt.I.registerLazySingleton<LocationRepository>(() => locationRepo);
    GetIt.I.registerLazySingleton<AttendanceRepository>(() => attendanceRepo);
    //========================================================================//

    ///Inject the blocs
    GetIt.I.registerFactory(() => LocationBloc());
    GetIt.I.registerFactory(() => DashboardBloc());
    GetIt.I.registerFactory(() => AttendanceBloc());
    //========================================================================//
  }

  ///Define static void of repositories
  static LocationRepository get locationRepository => GetIt.I();
  static AttendanceRepository get attendanceRepository => GetIt.I();
  //========================================================================//

  ///Define static void of blocs
  static LocationBloc get locationBloc => GetIt.I();
  static DashboardBloc get dashboardBloc => GetIt.I();
  static AttendanceBloc get attendanceBloc => GetIt.I();
  //========================================================================//
}