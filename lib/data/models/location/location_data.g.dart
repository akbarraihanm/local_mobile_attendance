// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationDataAdapter extends TypeAdapter<LocationData> {
  @override
  final int typeId = 0;

  @override
  LocationData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocationData(
      address: fields[0] as String?,
      latitude: fields[1] as dynamic,
      longitude: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, LocationData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.address)
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
      other is LocationDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
