import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TicketDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF48CAE4),
        toolbarHeight: 90,
        title: Row(
          children: [
            SizedBox(width: 25),
            Text(
              "Ticket Details",
              style: TextStyle(fontSize: 20),
            ),
            // SizedBox(width: 30),
            // Text(
            //   "Transaction",
            //   style: TextStyle(fontSize: 20),
            // ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("tickets_booked")
                  .where("uid", isEqualTo: "I0YIVmKZYAYUJ2rHhvIFDOelmF43")
                  .get(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error in retriving. Check your internet!");
                } else if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data.docs;
                  print(documents);
                }
                return const Text("Error in loading");
              }),
        ),
      ),
    );
  }
}
