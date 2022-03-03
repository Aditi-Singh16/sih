import 'package:flutter/material.dart';
import 'package:sih/ui/operator/edit_monument.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sih/ui/operator/home.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
        fontFamily: 'LibreBaskerville',
        scaffoldBackgroundColor: const Color(0xFFE0EFF6),
        bottomAppBarColor: const Color(0xff48CAE4),
        appBarTheme: const AppBarTheme(
            backgroundColor:Color(0xff48CAE4)
        )
    ),
    initialRoute: '/',
    routes: {
      "operatorHome" : (context)=>const OperatorHome(),
      "editMonument" : (context)=>const EditMonument(monumentIndex:'Monument_1')
    },
    home: const EditMonument(monumentIndex: 'Monument_1'),
  ));
}


