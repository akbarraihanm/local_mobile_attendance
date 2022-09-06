abstract class LocationState {}

class InitLocationState extends LocationState {}

class SuccessCreateLocationState extends LocationState {
  String message;

  SuccessCreateLocationState(this.message);
}

class ShowErrorLocationState extends LocationState {
  String message;

  ShowErrorLocationState(this.message);
}