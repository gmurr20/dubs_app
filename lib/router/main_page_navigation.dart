import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/repository/user_repository.dart';
import 'package:dubs_app/screen/chat/chat_page.dart';
import 'package:dubs_app/screen/home/home_page.dart';
import 'package:dubs_app/screen/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This widget handles all the routing between pages in the bottom navigation bar
class MainPageNavigationController extends StatefulWidget {
  User user;
  UserRepository userRepo;

  MainPageNavigationController(
      {Key key, @required this.user, @required this.userRepo})
      : assert(user != null),
        assert(userRepo != null),
        super(key: key);

  @override
  _MainPageNavigationControllerState createState() =>
      _MainPageNavigationControllerState();
}

class _MainPageNavigationControllerState
    extends State<MainPageNavigationController> {
  List<Widget> pages;
  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 1; // start on the home page

  User get _currentUser => widget.user;

  UserRepository get _userRepo => widget.userRepo;

  @override
  void initState() {
    pages = [
      ProfilePage(
        key: PageStorageKey('profile'),
        input: ProfilePageInput(_currentUser, _userRepo),
      ),
      HomePage(
        key: PageStorageKey('home'),
        input: HomePageInput(_currentUser, _userRepo),
      ),
      ChatPage(
          key: PageStorageKey("chat"),
          input: ChatPageInput(_currentUser, _userRepo))
    ];
  }

  BottomNavigationBar buildBottomNav(int selectedIndex) {
    return BottomNavigationBar(
      onTap: (int index) => setState(() => _selectedIndex = index),
      selectedItemColor: DarwinRed,
      currentIndex: selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Profile'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          title: Text('Message'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNav(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
