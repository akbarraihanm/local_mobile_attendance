import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';

abstract class LocationEvent {}

class GetListLocationEvent extends LocationEvent {}

class ChangeLocationEventState extends LocationEvent {}

class OnCameraIdleLocationEvent extends LocationEvent {
  CameraPosition cameraPosition;
  GoogleMapController controller;

  OnCameraIdleLocationEvent({
    required this.cameraPosition,
    required this.controller
  });
}

class CreateLocationEvent extends LocationEvent {
  LocationData data;

  CreateLocationEvent(this.data);
}