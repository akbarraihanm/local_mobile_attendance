import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hash_micro_test/core/util/resource.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/domain/repositories/location/location_repository.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_bloc.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_event.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_state.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late MockLocationRepository repository;

  setUpAll(() {
    repository = MockLocationRepository();

    DIObject.init();
    GetIt.I.unregister<LocationRepository>();
    GetIt.I.registerLazySingleton<LocationRepository>(() => repository);
  });

  group('LocationBloc - GetListLocationEvent test', () {
    blocTest(
      'Given location bloc '
      'When GetListLocationEvent getting error '
      'Then it should call ShowErrorLocationState',
      build: () {
        when(() => DIObject.locationBloc.useCase.getLocations())
            .thenAnswer((_) =>
            Future.value(Resource.error("An Error Occurred")));
        return DIObject.locationBloc;
      },
      wait: const Duration(seconds: 1),
      act: (LocationBloc bloc) => bloc.add(GetListLocationEvent()),
      expect: () => [isA<ShowErrorLocationState>()],
    );

    blocTest(
      'Given location bloc '
      'When GetListLocationEvent success '
      'Then it should call InitLocationState returning a list',
      build: () {
        when(() => DIObject.locationBloc.useCase.getLocations())
            .thenAnswer((_) =>
            Future.value(Resource.success([LocationData(
              address: "address", latitude: 0.0, longitude: 0.0
            )])));
        return DIObject.locationBloc;
      },
      wait: const Duration(seconds: 1),
      act: (LocationBloc bloc) => bloc.add(GetListLocationEvent()),
      expect: () => [isA<InitLocationState>()],
    );
  });
}