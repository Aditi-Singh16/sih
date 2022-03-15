import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sih/prefs/sharedPrefs.dart';
import 'package:sih/ui/user/ticket_details.dart';

class TicketHistory extends StatefulWidget {
  @override
  State<TicketHistory> createState() => _TicketHistoryState();
}

class _TicketHistoryState extends State<TicketHistory> {
  var uid = '0';
  setUID() async {
    var id = await HelperFunctions().readUserIdPref();
    setState(() {
      uid = id;
    });
  }

  @override
  void initState() {
    setUID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF48CAE4),
        title: Text(
          "Your Tickets",
          style: TextStyle(fontSize: 20),
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
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Ticket_Details(documents: documents)));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 25),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    documents[index]['monument_name'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Row(
                                      children: [
                                        SizedBox(width: 3),
                                        Text(
                                          documents[index]['time'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          "|",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          documents[index]['date'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    documents[index]['location'],
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: Center(
                                      child: Image.network(
                                          documents[index]['mainPic']),
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
                    );
                  },
                );
              }
              return const Text("Error");
            },
          ),
        ),
      ),
    );
  }
}
