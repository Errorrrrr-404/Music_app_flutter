import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music__app/modules/singers/widgets/starratting.dart';
import '../models/Singer.dart';
import 'package:music__app/modules/songs/pages/songs.dart';

class SingerBox extends StatelessWidget {
  Singer singer;
  SingerBox(this.singer);
 
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(image: NetworkImage(singer.url)),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 5, color: Colors.black12)),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => Songs(singer.name)));
              },
            )),
        Positioned(
          child: Text(
            singer.name,
            style: TextStyle(
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: 20,
          left: 50,
        ),
        // Positioned(
        //   child: StarRating(),
        //   top: 5,
        //   left: 10,
        // ),
        Positioned(
          top: 5,
          left: 5,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => Songs(singer.name)));
            },
            // child:  CircleAvatar(
            //   maxRadius: 0.1,
            child: Center(
              child: Icon(
                Icons.play_circle_filled_outlined,
                size: 30,
                color: Color.fromARGB(179, 243, 241, 241),
              ),
            ),
          ),
          //))
        )
      ],
    );
  }
}
