import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_indicator/loading_indicator.dart';
import './wave.dart';
import '../../songs/models/song.dart';

class MusicPlayer extends StatefulWidget {
  late Song song;
  MusicPlayer({required this.song});

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool _isPlaying = false;
  late AudioPlayer audioPlayer;
  late Duration _duration;
  late Duration _position;
  get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  get _positionText => _position?.toString()?.split('.')?.first ?? '';
  @override
  void initState() {
    _initAudioPlayer();
    playAudio(widget.song.songUrl);

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void _initAudioPlayer() {
    audioPlayer = AudioPlayer();

    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        setState(() {
          _isPlaying = false;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((p) => setState(() {
          _position = p;
        }));
  }

  playAudio(path) async {
    await audioPlayer.play(UrlSource(path));

    setState(() {
      _isPlaying = true;
    });
  }

  pauseAudio() async {
    await audioPlayer.pause();

    setState(() {
      _isPlaying = false;
    });
  }

  stopAudio() async {
    await audioPlayer.stop();

    setState(() {
      _isPlaying = false;
    });
  }

  resumeAudio() async {
    await audioPlayer.resume();

    setState(() {
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.blueGrey,
              height: height * 0.40,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: 190,
                    width: 190,
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(widget.song.photo),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
              opacity: _isPlaying ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Wave(
                size: Size(MediaQuery.of(context).size.width, 50),
                isPlaying: _isPlaying,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${widget.song.trackName}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("${widget.song.trackName}"),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Stack(
                    children: [
                      Slider(
                        onChanged: (v) {
                          final Position = v * _duration.inMilliseconds;
                          audioPlayer
                              .seek(Duration(milliseconds: Position.round()));
                        },
                        value: (_position != null &&
                                _duration != null &&
                                _position.inMilliseconds > 0 &&
                                _position.inMilliseconds <
                                    _duration.inMilliseconds)
                            ? _position.inMilliseconds /
                                _duration.inMilliseconds
                            : 0.0,
                      ),
                    ],
                  ),
                ),
                Text(
                  _position != null
                      ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                      : _duration != null
                          ? _durationText
                          : '',
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.volume_off,
                    size: 30,
                  ),
                  onPressed: () async {
                    await audioPlayer.setVolume(0.0);
                  },
                ),
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 30,
                  ),
                  onPressed: () {
                    if (_isPlaying == true) {
                      pauseAudio();
                    } else {
                      resumeAudio();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.stop,
                    size: 30,
                  ),
                  onPressed: () {
                    stopAudio();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.volume_up,
                    size: 30,
                  ),
                  onPressed: () async {
                    await audioPlayer.setVolume(1.0);
                  },
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                child: Text('Add to PlayList'),
                onPressed: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
