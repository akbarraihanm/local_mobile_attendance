import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hash_micro_test/core/util/app_util.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_event.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_state.dart';

import '../../../domain/use_cases/location/location_use_case.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  late LocationUseCase _useCase;
  Position? position;
  Iterable<LocationData> _locations = [];
  String address = "";

  LocationUseCase get useCase => _useCase;
  Iterable<LocationData> get locations => _locations;

  ///Create Location
  dynamic latitude;
  dynamic longitude;

  LocationBloc(): super(InitLocationState()) {
    _useCase = LocationUseCase(DIObject.locationRepository);

    on<ChangeLocationEventState>((event, emit) => emit(InitLocationState()));

    on<GetListLocationEvent>((event, emit) async {
      final result = await _useCase.getLocations();

      ///Use this delay in case for real implementation using REST API
      await Future.delayed(const Duration(seconds: 1), () {
        if (result.message != null) {
          emit(ShowErrorLocationState(result.message ?? ""));
        } else {
          _locations = result.data ?? [];
          emit(InitLocationState());
        }
      });
    });

    on<OnCameraIdleLocationEvent>((event, emit) async {
      final mapController = event.controller;
      final cameraPosition = event.cameraPosition;
      final result = await mapController.getScreenCoordinate(
          cameraPosition.target);
      final latLng = await mapController.getLatLng(ScreenCoordinate(
        x: result.x,
        y: result.y
      ));
      address = await AppUtil.getAddress(latLng.latitude, latLng.longitude);
      latitude = latLng.latitude;
      longitude = latLng.longitude;
      emit(InitLocationState());
    });

    on<CreateLocationEvent>((event, emit) async {
      var data = event.data;
      var address = await AppUtil.getAddress(data.latitude, data.longitude);
      data.address = address;

      final result = await _useCase.createLocation(data);

      await Future.delayed(const Duration(seconds: 1), () {
        if (result.message != null) {
          emit(ShowErrorLocationState(result.message ?? ""));
        } else {
          emit(SuccessCreateLocationState("Location has been added"));
        }
      });
    });
  }
}