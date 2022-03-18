import 'package:flutter/material.dart';
import 'package:sih/ui/ticket_checker/home.dart';
import 'package:sih/ui/user/acc.dart';

class TicketBottomNavBar extends StatefulWidget {
  const TicketBottomNavBar({Key? key}) : super(key: key);

  @override
  _TicketBottomNavBarState createState() => _TicketBottomNavBarState();
}

class _TicketBottomNavBarState extends State<TicketBottomNavBar> {
  int pageIndex = 0;

  final pages = [
    TicketCheckerHome(),
    UserAccount()
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
