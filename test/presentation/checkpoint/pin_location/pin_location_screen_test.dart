import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/domain/repositories/location/location_repository.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_bloc.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_event.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_state.dart';
import 'package:hash_micro_test/presentation/checkpoint/pin_location/pin_location_screen.dart';
import 'package:hash_micro_test/presentation/dashboard/dashboard_screen.dart';
import 'package:hash_micro_test/presentation/widgets/app_button.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
    implements LocationBloc {}

class MockNavigationObserver extends Mock implements NavigatorObserver {}

class RouteFake extends Mock implements Route {}

void main() {
  late MockLocationRepository repository;
  late MockNavigationObserver observer;
  late MockLocationBloc bloc;

  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
    DIObject.init();

    repository = MockLocationRepository();
    observer = MockNavigationObserver();
    bloc = MockLocationBloc();

    GetIt.I.unregister<LocationRepository>();
    GetIt.I.unregister<LocationBloc>();
    GetIt.I.registerLazySingleton<LocationRepository>(() => repository);
    GetIt.I.registerFactory<LocationBloc>(() => bloc);

    registerFallbackValue(RouteFake());
  });

  Widget createPinLocation() => MaterialApp(
    initialRoute: PinLocationScreen.routeName,
    navigatorObservers: [observer],
    routes: {
      PinLocationScreen.routeName: (context) => const PinLocationScreen(),
      DashboardScreen.routeName: (context) => const SizedBox(),
    },
  );

  testWidgets(
      'Given pin location screen '
      'When first time open screen and Position = null '
      'Then it should show loading text', (tester) async {

        when(() => bloc.state).thenReturn(InitLocationState());

        await tester.pumpWidget(createPinLocation());
        await tester.pumpAndSettle();

        final icon = find.byType(Icon).evaluate().first.widget as Icon;

        expect(find.text("Loading Map"), findsOneWidget);
        expect(icon.icon, Icons.location_on);
  });

  testWidgets(
      'Given pin location screen '
      'When first time open screen and Position != null '
      'Then it should show correct widgets', (tester) async {

      when(() => bloc.position).thenReturn(Position(
        timestamp: DateTime.now(),
        speedAccuracy: 0,
        speed: 0,
        heading: 0,
        altitude: 0,
        accuracy: 0,
        longitude: 1.1,
        latitude: 2.2,
        isMocked: true,
        floor: 0
      ));
      when(() => bloc.address).thenReturn("Address");
      when(() => bloc.state).thenReturn(InitLocationState());

      await tester.pumpWidget(createPinLocation());
      await tester.pumpAndSettle();

      expect(find.byType(GoogleMap), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(AppButton), findsOneWidget);
  });

  testWidgets(
      'Given pin location screen '
      'When tap back button '
      'Then it should navigate pop', (tester) async {

        await tester.pumpWidget(createPinLocation());
        await tester.pumpAndSettle();
        await tester.tap(find.byType(BackButton));

        verify(() => observer.didPop(captureAny(), any()));
  });

  testWidgets(
      'Given pin location screen '
      'When tap confirm button '
      'Then it should call SuccessCreateLocationState', (tester) async {

        when(() => bloc.position).thenReturn(Position(
            timestamp: DateTime.now(),
            speedAccuracy: 0,
            speed: 0,
            heading: 0,
            altitude: 0,
            accuracy: 0,
            longitude: 1.1,
            latitude: 2.2,
            isMocked: true,
            floor: 0
        ));
        when(() => bloc.address).thenReturn("Address");
        when(() => bloc.state).thenReturn(InitLocationState());

        await tester.pumpWidget(createPinLocation());
        await tester.pumpAndSettle();

        when(() => bloc.latitude).thenReturn(1.1);
        when(() => bloc.longitude).thenReturn(2.2);
        when(() => bloc.state).thenReturn(SuccessCreateLocationState("OK"));
        await tester.tap(find.text("Confirm"), warnIfMissed: false);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        verifyNever(() => observer.didPop(captureAny(), any()));
  });
}