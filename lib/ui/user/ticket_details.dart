import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sih/prefs/sharedPrefs.dart';

class Ticket_Details extends StatefulWidget {
  const Ticket_Details({required this.documents, Key? key}) : super(key: key);
  final List<DocumentSnapshot> documents;

  @override
  State<Ticket_Details> createState() => _Ticket_DetailsState();
}

class _Ticket_DetailsState extends State<Ticket_Details> {
  String uid = "";
  getInfo() async {
    HelperFunctions _helperFunctions = HelperFunctions();
    var ress = uid = await _helperFunctions.readUserIdPref();
    setState(() {
      uid = ress;
    });
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  GlobalKey globalKey = new GlobalKey();

  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.04;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff48CAE4),
              title: const Text('Ticket detail'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Navigator.pop(context, false),
              ),
            ),
            backgroundColor: Colors.white,
            body: Container(
              decoration: BoxDecoration(
                color: const Color(0xffC8E3EF),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.documents.length,
                  itemBuilder: (context, snap) {
                    return Column(
                      children: [
                        SizedBox(
                          height: height * 0.04,
                        ),
                        //space
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Image.network(
                              widget.documents[0]['mainPic'],
                              width: width * 10,
                              height: height * 0.27,
                            )),
                        SizedBox(
                          height: height * 0.006,
                        ),
                        //monument name
                        Text(
                          widget.documents[0]['monument_name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: fontSize),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        //space
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.documents[0]['time'] +
                                              " " +
                                              "|",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: fontSize),
                                        ),
                                        Text(
                                          widget.documents[0]['date'] + " ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: fontSize),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      widget.documents[0]['location'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: fontSize),
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: RepaintBoundary(
                                        key: globalKey,
                                        child: QrImage(
                                          data: uid +
                                              "_" +
                                              widget.documents[0]['members']
                                                  .length
                                                  .toString(),
                                          size: height * 0.27,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )));
  }
}
