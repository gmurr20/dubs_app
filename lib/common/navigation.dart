import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/model/user.dart';
import 'package:dubs_app/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NavigationPageResult { HOME, CHAT, PROFILE }

class NavigationHelper {
  static int pageToIndex(NavigationPageResult pageRes) {
    switch (pageRes) {
      case NavigationPageResult.HOME:
        {
          return 1;
        }
      case NavigationPageResult.CHAT:
        {
          return 2;
        }
      case NavigationPageResult.PROFILE:
        {
          return 0;
        }
    }
  }

  static NavigationPageResult indexToPage(int index) {
    switch (index) {
      case 0:
        {
          return NavigationPageResult.PROFILE;
        }
      case 1:
        {
          return NavigationPageResult.HOME;
        }
      case 2:
        {
          return NavigationPageResult.CHAT;
        }
      default:
        {
          return NavigationPageResult.HOME;
        }
    }
  }

  static void _onNavigation(NavigationPageResult navigateTo,
      NavigationPageResult currentPage, BuildContext context, User user) {
    if (navigateTo == currentPage) {
      return;
    }
    switch (navigateTo) {
      case NavigationPageResult.PROFILE:
        {
          //     Navigator.of(context)
          // //                     .pushNamed(homeRoute, arguments: user);
          break;
        }
      case NavigationPageResult.HOME:
        {
          Navigator.of(context).pushNamed(homeRoute, arguments: user);
          break;
        }
      case NavigationPageResult.CHAT:
        {
          // Navigator.of(context)
          //                     .pushNamed(homeRoute, arguments: user);
          break;
        }
      default:
        {}
    }
  }

  static BottomNavigationBar buildBottomNav(
      NavigationPageResult currentPage, BuildContext context, User user) {
    return BottomNavigationBar(
      onTap: (int arg) =>
          _onNavigation(indexToPage(arg), currentPage, context, user),
      selectedItemColor: DarwinRed,
      currentIndex: pageToIndex(currentPage),
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
          title: Text('Chat'),
        ),
      ],
    );
  }
}
