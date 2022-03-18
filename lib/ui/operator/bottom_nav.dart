import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sih/ui/operator/add_ticket_checker.dart';
import 'package:sih/ui/operator/home.dart';
import 'package:sih/ui/operator/show_graphs.dart';
import 'package:sih/ui/user/acc.dart';

class OperatorBottomNavBar extends StatefulWidget {
  const OperatorBottomNavBar({Key? key}) : super(key: key);

  @override
  _OperatorBottomNavBarState createState() => _OperatorBottomNavBarState();
}

class _OperatorBottomNavBarState extends State<OperatorBottomNavBar> {
  int pageIndex = 0;

  final pages = [
    OperatorHome(),
    ShowGraph(day: 0),
    AddTicketChecker(),
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
                    CupertinoIcons.graph_square_fill,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height / 24,
                  )
                : Icon(
                    CupertinoIcons.graph_square,
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
                    Icons.person_add_alt_1_outlined,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height / 24,
                  )
                : Icon(
                    Icons.person_add_alt_1,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height / 24,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
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
