import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/domain/repositories/location/location_repository.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_bloc.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_event.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_state.dart';
import 'package:hash_micro_test/presentation/checkpoint/list/checkpoint_screen.dart';
import 'package:hash_micro_test/presentation/checkpoint/pin_location/pin_location_screen.dart';
import 'package:hash_micro_test/presentation/widgets/empty_data.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

class MockNavigationObserver extends Mock implements NavigatorObserver {}

class RouteFake extends Mock implements Route {}

class MockLocationData extends Mock implements LocationData {}

void main() {
  late MockLocationRepository repository;
  late MockNavigationObserver observer;
  late MockLocationBloc bloc;
  late MockLocationData data;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    DIObject.init();

    repository = MockLocationRepository();
    observer = MockNavigationObserver();
    bloc = MockLocationBloc();
    data = MockLocationData();

    GetIt.I.unregister<LocationRepository>();
    GetIt.I.unregister<LocationBloc>();
    GetIt.I.registerLazySingleton<LocationRepository>(() => repository);
    GetIt.I.registerFactory<LocationBloc>(() => bloc);

    when(() => data.address).thenReturn("Address");
    when(() => data.latitude).thenReturn(1.1);
    when(() => data.longitude).thenReturn(2.2);

    registerFallbackValue(RouteFake());
  });

  Widget createCheckpoint() => MaterialApp(
    home: const CheckpointScreen(),
    navigatorObservers: [observer],
    routes: {
      PinLocationScreen.routeName: (context) => const SizedBox(),
    },
  );

  testWidgets(
      'Given checkpoint screen '
      'When first time open and location list is empty '
      'Then it should show EmptyData widget', (tester) async {

        when(() => bloc.locations).thenReturn([]);
        when(() => bloc.state).thenReturn(InitLocationState());

        await tester.pumpWidget(createCheckpoint());
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(bloc.locations.isEmpty, true);
        expect(find.byType(EmptyData), findsOneWidget);
  });

  testWidgets(
      'Given checkpoint screen '
      'When first time open and location list not empty '
      'Then it should return widget with correct data', (tester) async {

        when(() => bloc.locations).thenReturn([data]);
        when(() => bloc.state).thenReturn(InitLocationState());

        await tester.pumpWidget(createCheckpoint());
        await tester.pumpAndSettle(const Duration(seconds: 1));

        expect(bloc.locations.isEmpty, false);
        expect(find.byType(Card), findsOneWidget);
        expect(find.text("Address"), findsOneWidget);
        expect(find.text("LatLng : 1.1, 2.2"), findsOneWidget);
  });

  testWidgets(
      'Given checkpoint screen '
      'When user tap on FloatingActionButton '
      'Then it should navigate to PinLocationScreen', (tester) async {

        when(() => bloc.locations).thenReturn([data]);
        when(() => bloc.state).thenReturn(InitLocationState());

        await tester.pumpWidget(createCheckpoint());
        await tester.pumpAndSettle(const Duration(seconds: 1));
        await tester.tap(find.byType(FloatingActionButton));

        verify(() => observer.didPush(captureAny(), any()));
  });
}