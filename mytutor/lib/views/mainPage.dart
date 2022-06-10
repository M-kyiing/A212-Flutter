import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:mytutor/views/subjectpage.dart';
import 'package:mytutor/views/subscribe.dart';
import 'package:mytutor/views/tutorProfile.dart';
import 'package:mytutor/views/userprofile.dart';
import 'favPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late PageController _pageController;
  final screens = [
    const SubjectPage(),
    const TutorPage(),
    const SubPage(),
    const FavPage(),
    const UserProfile(),
  ];
  late double screenHeight, screenWidth, resWidth;

  @override
  void initState() {
    super.initState();
    // _loadSubject(1, search);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: screens),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: const Text('Subjects'),
              icon: const FaIcon(FontAwesomeIcons.bookOpen),
              activeColor: HexColor('#457b9d'),
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              title: const Text('Tutors'),
              icon: const FaIcon(FontAwesomeIcons.chalkboardUser),
              activeColor: HexColor('#457b9d'),
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              title: const Text('Subscribe'),
              icon: const FaIcon(FontAwesomeIcons.bookMedical),
              activeColor: HexColor('#457b9d'),
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              title: const Text('Favourite'),
              icon: const FaIcon(FontAwesomeIcons.heartCirclePlus),
              activeColor: HexColor('#457b9d'),
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              title: const Text('Profile'),
              icon: const FaIcon(FontAwesomeIcons.user),
              activeColor: HexColor('#457b9d'),
              inactiveColor: Colors.black),
        ],
      ),
    );
  }
}
