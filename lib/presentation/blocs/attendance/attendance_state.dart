abstract class AttendanceState {}

class InitAttendanceState extends AttendanceState {}

class ShowLoadingAttendanceState extends AttendanceState {}

class SuccessCreateAttendanceState extends AttendanceState {
  String message;

  SuccessCreateAttendanceState(this.message);
}

class ShowErrorAttendanceState extends AttendanceState {
  String message;

  ShowErrorAttendanceState(this.message);
}