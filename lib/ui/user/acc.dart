import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sih/prefs/sharedPrefs.dart';

class UserAccount extends StatefulWidget {
  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  var uid = "";

  setInfo() async {
    var resid = await HelperFunctions().readUserIdPref();
    setState(() {
      uid = resid;
    });
  }

  @override
  void initState() {
    setInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF48CAE4),
        title: 
            Text(
              "Account",
              style: TextStyle(fontSize: 20),
            ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .where('uid', isEqualTo: uid)
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              print(snapshot);
              if (snapshot.hasError) {
                return const Text("error");
              } else if (snapshot.hasData) {
                final List<DocumentSnapshot> documents = snapshot.data.docs;
                print('hi');
                return ListView(
                    //iterating
                    children: documents
                        .map(
                          (doc) => Container(
                            margin: EdgeInsets.only(bottom: 25),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/profile.png'),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFF48CAE4),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Name: ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            doc['name'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            "Phone no: ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            doc['phone'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            "Nationality: ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            doc['nationality'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            "Role: ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            doc['type'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Logout",
                                            style: TextStyle(
                                                color: Colors.black,
                                                backgroundColor: Colors.white),
                                          )),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffb6daeb),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(50),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.height / 30,
                                      ),
                                      child: Text(
                                        "Contact Us: admin@ticketfolio.com",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                22,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
