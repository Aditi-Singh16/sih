import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sih/ui/ticket_checker/home.dart';
import 'ui/Login/signup_page.dart';
import 'package:sih/ui/user/ticket_history.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TicketHistory(),
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFC8E3EF)),
    );
  }
}
