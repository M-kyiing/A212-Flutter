import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SubPage extends StatelessWidget {
  const SubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tutor - Subscribe',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Tutor - Subscribe'),
          backgroundColor: HexColor('#457b9d'),
        ),
        body: const Padding(
          padding: EdgeInsets.fromLTRB(120, 10, 0, 0),
          child: Text("Subscribed Subjects",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
