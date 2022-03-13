import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sih/prefs/sharedPrefs.dart';

class TicketHistory extends StatefulWidget {
  @override
  State<TicketHistory> createState() => _TicketHistoryState();
}

class _TicketHistoryState extends State<TicketHistory> {
  var uid = '0';
  @override
  void initState() async {
    uid = await HelperFunctions().readUserIdPref();
    super.initState();
  }

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
              "Your Tickets",
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
        padding: EdgeInsets.all(25),
        child: Center(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("tickets_booked")
                .where("uid", isEqualTo: uid)
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Text("error");
              } else if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data.docs;
                print(documents);
                return ListView(
                    //iterating
                    children: documents
                        .map(
                          (doc) => Container(
                            margin: EdgeInsets.only(bottom: 25),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  width: 190,
                                  child: Column(
                                    children: [
                                      //details
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        doc['monument_name'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Row(
                                          children: [
                                            SizedBox(width: 3),
                                            Text(
                                              doc['time'],
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              "|",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              doc['date'],
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        doc['location'],
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),
                                Flexible(
                                  child: Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: EdgeInsets.all(1),
                                        child: Center(
                                          child: Image.network(doc['image']),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF48CAE4),
                            ),
                          ),
                        )
                        .toList());
              }
              return const Text("Error");
            },
          ),
        ),
      ),
    );
  }
}
