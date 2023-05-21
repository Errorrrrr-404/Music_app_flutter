import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../shared/services/api_client.dart';
import '../models/song.dart';

class SongService {
  ApiClient apiClient = ApiClient();
  Future<List<Song>> getsongs(String singerName) async {
    final URL = 'https://itunes.apple.com/search?term=$singerName&limit=25';
    Response response = await apiClient.get(URL);
    //print(response.data);
    //print(response.data.runtimeType);
    Map<String, dynamic> map = jsonDecode(response.data);
    print("MAP IS ************");
    List<dynamic> list = map['results'];
    List<Song> songs = list.map((e) => Song.SongFromJSON(e)).toList();

    print(map);
    return songs;
  }
}
