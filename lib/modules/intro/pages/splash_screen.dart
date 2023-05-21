import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music__app/modules/singers/models/Singer.dart';
import 'package:music__app/modules/singers/pages/singer_view.dart';
import 'package:music__app/shared/config.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  _moveToNextScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SingerView()));
  }

  _loadAndMove() {
    Timer(Duration(seconds: 4), () {
      _moveToNextScreen();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAndMove();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: media.width,
              height: media.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, Colors.tealAccent, Colors.brown],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(Constants.SPLASH_IMG_URL),
                  Text(
                    'Music App 2023',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  Text('All CopyRight Reserved'),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber)),
                        onPressed: () {
                          _moveToNextScreen();
                        },
                        child: Text('Go Further'),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
