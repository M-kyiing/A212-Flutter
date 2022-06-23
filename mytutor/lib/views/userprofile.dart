import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/user.dart';
import 'loginscreen.dart';

class UserProfile extends StatefulWidget {
  // final User user;
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final double coverHeight = 160;
  final double profileHeight = 120;
  List<User> userList = <User>[];
  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight / 2;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Tutor - User Profile'),
        backgroundColor: HexColor('#457b9d'),
      ),
      body: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              // color: Colors.grey,
              width: double.infinity,
              height: coverHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/cover.jpeg'),
                ),
              ),
            ),
            Positioned(
              top: top,
              child: CircleAvatar(
                radius: profileHeight / 2,
                backgroundImage: const AssetImage('assets/images/profile.jpeg'),
              ),
            ),
          ]),
    );
  }
}
