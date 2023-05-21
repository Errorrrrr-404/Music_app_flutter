import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:music__app/modules/songs/pages/songs.dart';
import '../models/Singer.dart';

class StarRating extends StatelessWidget {
  //int rating;
  //StarRating(this.rating);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 3,
      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.white,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
