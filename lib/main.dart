import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sih/backend/local_data.dart';
import 'package:sih/ui/operator/add_ticket_checker.dart';
import 'package:sih/ui/operator/edit_monument.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sih/ui/operator/home.dart';
import 'package:sih/ui/user/home.dart';
import 'package:sih/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      fontFamily: 'LibreBaskerville',
      scaffoldBackgroundColor: const Color(0xFFE0EFF6),
      bottomAppBarColor: const Color(0xff48CAE4),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff48CAE4)),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
    initialRoute: 'UserHome',
    routes: {
      "operatorHome": (context) => OperatorHome(),
      "editMonument": (context) => const EditMonument(),
      "addTicketChecker": (context) => AddTicketChecker(),
      "UserHome": (context) => UserHome(),
    },
    home: const Wrapper(),
  ));
}
