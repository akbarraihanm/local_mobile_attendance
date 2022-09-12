

abstract class AttendanceEvent {}

class ChangeAttendanceStateEvent extends AttendanceEvent {}

class GetListAttendanceEvent extends AttendanceEvent {}

class CreateAttendanceEvent extends AttendanceEvent {
  dynamic pinLatitude;
  dynamic pinLongitude;

  CreateAttendanceEvent({this.pinLatitude, this.pinLongitude});
}