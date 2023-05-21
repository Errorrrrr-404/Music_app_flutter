import 'package:json_annotation/json_annotation.dart';

part 'song.g.dart';

@JsonSerializable()
class Song {
  // @JsonKey(name: "trackName")
  late String trackName;
  @JsonKey(name: "artworkUrl100")
  late String photo;
  @JsonKey(name: "previewUrl")
  late String songUrl;

  static Song SongFromJSON(Map<String, dynamic> map) => _$SongFromJson(map);
}
