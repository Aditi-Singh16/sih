import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sih/ui/user/UserBottomNav.dart';
import 'package:sih/ui/user/UserHome.dart';
import 'package:sih/ui/user/detailsPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
        fontFamily: 'LibreBaskerville',
        scaffoldBackgroundColor: const Color(0xFFE0EFF6),
        // bottomAppBarColor: const Color(0xff5D95A9),
        bottomAppBarColor: const Color(0xff48CAE4),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.white, fontSize: 20),
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xff48CAE4))),
    initialRoute: '/BottomNavBar',
    routes: {
      "/BottomNavBar": (context) => UserBottomNavBar(),
      // "/details": (context) => DetailsPage(),
    },
  ));
}
