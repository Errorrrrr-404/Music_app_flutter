import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:music__app/modules/singers/service/singer_service.dart';
import 'package:music__app/modules/singers/widgets/singerbox.dart';

import '../models/Singer.dart';

class SingerView extends StatefulWidget {
  const SingerView({super.key});

  @override
  State<SingerView> createState() => _SingerViewState();
}

class _SingerViewState extends State<SingerView> {
  SingerService _singerService = SingerService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_singerService.getSingers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Singers')),
      body: Container(
          child: FutureBuilder<List<Singer>>(
        future: _singerService.getSingers() ,
        builder: (ctx, AsyncSnapshot<List<Singer>> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Something Went Wrong....');
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (contxt, int index) {
              Singer singer = snapshot.data![index];
              return SingerBox(singer);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          );
        },
      )),
    );
  }
}
