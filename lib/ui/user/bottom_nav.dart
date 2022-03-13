import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sih/ui/user/user_account.dart';
import 'package:sih/ui/user/home.dart';
import 'package:sih/ui/user/booking_history.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({Key? key}) : super(key: key);

  @override
  _UserBottomNavBarState createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  int pageIndex = 0;

  final pages = [
    UserHome(),
    BookingHistory(),
    UserAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 12,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? Icon(
              Icons.home,
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 24,
            )
                : Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 24,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? Icon(
              CupertinoIcons.tickets_fill,
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 24,
            )
                : Icon(
              CupertinoIcons.tickets,
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 24,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? Icon(
              Icons.person,
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 24,
            )
                : Icon(
              Icons.person_outline,
              color: Colors.white,
              size: MediaQuery.of(context).size.height / 24,
            ),
          ),
        ],
      ),
    );
  }
}
