import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/presentation/blocs/dashboard/dashboard_bloc.dart';
import 'package:hash_micro_test/presentation/blocs/dashboard/dashboard_event.dart';
import 'package:hash_micro_test/presentation/blocs/dashboard/dashboard_state.dart';

void main() {
  setUpAll(() {
    DIObject.init();
  });

  group('Dashboard Bloc test', () {
    blocTest(
      'Given dashboard bloc '
      'When ChangeMenuDashboardEvent called with "0" index '
      'Then it should call InitDashboardState',
      build: () => DIObject.dashboardBloc,
      act: (DashboardBloc bloc) => bloc.add(ChangeMenuDashboardEvent(0)),
      expect: () => [isA<InitDashboardState>()],
    );

    blocTest(
      'Given dashboard bloc '
      'When ChangeMenuDashboardEvent called with "1" index '
      'Then it should call LocationMenuState',
      build: () => DIObject.dashboardBloc,
      act: (DashboardBloc bloc) => bloc.add(ChangeMenuDashboardEvent(1)),
      expect: () => [isA<LocationMenuState>()],
    );
  });
}