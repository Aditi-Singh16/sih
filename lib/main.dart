import 'package:flutter/material.dart';
import 'package:sih/ui/operator/ticket_details.dart';
import 'package:sih/ui/operator/moument_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/ticks',
    routes:{
      '/ticks': (context) => ticks(),

    },
  ));

}


