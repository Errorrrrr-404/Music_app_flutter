// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song()
  ..trackName = json['trackName'] ?? '' as String
  ..photo = json['artworkUrl100'] ?? '' as String
  ..songUrl = json['previewUrl'] ?? '' as String;

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'trackName': instance.trackName,
      'artworkUrl100': instance.photo,
      'previewUrl': instance.songUrl,
    };
