import 'package:flutter/material.dart';
import 'package:sih/ui/operator/add_ticket_checker.dart';
import 'package:sih/ui/operator/edit_monument.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sih/ui/operator/home.dart';
import 'package:sih/ui/operator/show_graphs.dart';
import 'package:sih/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      fontFamily: 'LibreBaskerville',
      scaffoldBackgroundColor: const Color(0xFFE0EFF6),
      bottomAppBarColor: const Color(0xff48CAE4),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xff48CAE4)),
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
    initialRoute: '/',
    routes: {
      "operatorHome": (context) => OperatorHome(),
      "editMonument": (context) => const EditMonument(),
      "addTicketChecker": (context) => AddTicketChecker(),
      "show_graphs": (context) => ShowGraph(day: 1),
    },
    home: Wrapper(),
  ));
}
