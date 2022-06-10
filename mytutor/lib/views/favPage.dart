import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FavPage extends StatelessWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tutor - Favourite',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Tutor - Favourite'),
          backgroundColor: HexColor('#457b9d'),
        ),
        body: const Padding(
          padding: EdgeInsets.fromLTRB(130, 10, 0, 0),
          child: Text("Favourite Subjects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
