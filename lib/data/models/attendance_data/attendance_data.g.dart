// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceDataAdapter extends TypeAdapter<AttendanceData> {
  @override
  final int typeId = 1;

  @override
  AttendanceData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceData(
      dateTime: fields[0] as DateTime?,
      latitude: fields[1] as dynamic,
      longitude: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
