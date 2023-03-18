// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkAdapter extends TypeAdapter<Bookmark> {
  @override
  final int typeId = 0;

  @override
  Bookmark read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bookmark()
      ..id = fields[0] as String?
      ..title = fields[1] as String?
      ..author = fields[2] as String?
      ..description = fields[3] as String?
      ..views = fields[4] as String?
      ..imageLink = fields[5] as String?
      ..updateTime = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, Bookmark obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.views)
      ..writeByte(5)
      ..write(obj.imageLink)
      ..writeByte(6)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
