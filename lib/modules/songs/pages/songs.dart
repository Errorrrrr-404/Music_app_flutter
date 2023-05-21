import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:music__app/modules/songs/sevices/song_service.dart';
import 'package:music__app/modules/player/pages/music_player.dart';

import '../models/song.dart';

class Songs extends StatefulWidget {
  String singerName;
  Songs(this.singerName);

  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  SongService _songService = SongService();

  _getContainer(Song song) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        shadowColor: Colors.deepOrange,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListTile(
              leading: Image.network(song.photo),
              subtitle: Text(song.trackName),
              trailing: IconButton(
                  onPressed: () {
                    //_playSong(song[index]['previewUrl']);

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ct) => MusicPlayer(song: song)));
                    //MusicPlayer(song: songObj);
                  },
                  icon: Icon(
                    Icons.play_circle_filled,
                    size: 30,
                    color: Colors.blue,
                  )),
              title: Text(song.trackName
                  // song.name
                  //   .substring(0, song.name.length > 30 ? 30 : song.name.length),
                  )),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Future<List<Song>> songs = _songService.getSongs(widget.singerName);
    //songs.then((value) => print(value)).catchError((e) => print(e));
  }

  AudioPlayer player = AudioPlayer();
  // _playSong() {
  //   player.play(UrlSource(
  //       'https://audio-ssl.itunes.apple.com/itunes-assets/Music1/v4/53/5a/c9/535ac941-f60e-c959-9dd7-d868f6e06fd1/mzaf_333195531905150300.plus.aac.p.m4a'));
  //   print("Playing");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: _songService.getsongs(widget.singerName),
        builder: (BuildContext ctx, AsyncSnapshot asyncSnapShot) {
          if (asyncSnapShot.data == null) {
            return Center(
              child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,

                  /// Required, The loading type of the widget
                  colors: const [Colors.white],

                  /// Optional, The color collections
                  strokeWidth: 2,

                  /// Optional, The stroke of the line, only applicable to widget which contains line
                  backgroundColor: Colors.black,

                  /// Optional, Background of the widget
                  pathBackgroundColor: Colors.black

                  /// Optional, the stroke backgroundColor
                  ),
            );
          }
          print("ASYNC SNAP SHOT DATA LEN ${asyncSnapShot.data.length}");
          return ListView.builder(
              itemCount: asyncSnapShot.data.length,
              itemBuilder: (BuildContext parent, int index) {
                return _getContainer(asyncSnapShot.data[index]);
              });
        },
      )),
      // body: ElevatedButton(
      //   child: Icon(
      //     Icons.play_arrow,
      //     size: 30,
      //   ),
      //   onPressed: () {
      //     _playSong();
      //   },
      // ),
      appBar: AppBar(
        title: Text(
          widget.singerName,
          style: TextStyle(fontSize: 30),
        ),
      ),
      backgroundColor: Colors.amberAccent,
    );
  }
}
