import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sih/prefs/sharedPrefs.dart';
import 'package:sih/ui/operator/edit_monument.dart';

class OperatorHome extends StatefulWidget {
  @override
  State<OperatorHome> createState() => _OperatorHomeState();
}

class _OperatorHomeState extends State<OperatorHome> {
  var uid = "";
  getInfo() async {
    HelperFunctions _helperFunctions = HelperFunctions();
    uid = await _helperFunctions.readUserIdPref();
    print("uid is");
    print(uid);
    setState(() {});
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('Monument')),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('monument_details')
            .where('operatorID', isEqualTo: uid)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          } else if (snapshot.hasData) {
            print("eheh");
            print(snapshot.data.toString());
            print(uid);
            final specificDocument = snapshot.data.docs;
            print(specificDocument);
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: specificDocument.length,
              itemBuilder: (context, snap) {
                return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10.0, right: 10, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              snapshot.data.docs[snap]['monumentName'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff48CAE4),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            CircleAvatar(
                              backgroundColor: Color(0xff48CAE4),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditMonument()));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
    
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 100),
                        child: Card(
                          elevation: 5,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blueGrey.shade900),
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.height / 100),
                            height: MediaQuery.of(context).size.height / 3.5,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Carousel(
                                boxFit: BoxFit.cover,
                                autoplay: true,
                                animationCurve: Curves.fastOutSlowIn,
                                animationDuration: Duration(milliseconds: 600),
                                dotSize: 6.0,
                                dotIncreasedColor: Color(0xff48CAE4),
                                dotBgColor: Colors.transparent,
                                dotPosition: DotPosition.bottomCenter,
                                dotVerticalPadding: 10.0,
                                showIndicator: true,
                                borderRadius: true,
                                indicatorBgPadding: 7.0,
                                images: [
                                  Image.network(
                                      snapshot.data.docs[snap]['gallery'][0]),
                                  Image.network(
                                      snapshot.data.docs[snap]['gallery'][1]),
                                  Image.network(
                                      snapshot.data.docs[snap]['gallery'][2]),
                                  Image.network(
                                      snapshot.data.docs[snap]['gallery'][3]),
                                  Image.network(
                                      snapshot.data.docs[snap]['gallery'][4]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
    
                      //monument name
    
                      SizedBox(
                        height: height * 0.009,
                      ),
                      //space
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
                              snapshot.data.docs[snap]["desc"],
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 22,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
              },
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: SpinKitFadingCube(
                  color: Color(0xFF48CAE4),
                  size: 50.0,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
