import 'dart:math' show cos, sqrt, asin;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sih/ui/user/details_page.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({Key? key}) : super(key: key);

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

func(listy, document, context) {}

class _RecommendationsState extends State<Recommendations> {
  double lat = 0;
  double long = 0;
  double userLat = 0;
  double userLong = 0;
  late double dist = 0;
  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userLat = position.latitude;
    userLong = position.longitude;
  }

  List<Widget> distance(List<DocumentSnapshot> documents) {
    List<Widget> listy = [SizedBox(height: 10)];
    documents.forEach((DocumentSnapshot document) {
      lat = document['lat'];
      long = document['long'];
      dist = calculateDistance(userLat, userLong, lat, long);
      print(dist);
      if (dist <= 8500) {
        listy.add(InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(detail: document),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: NetworkImage(
                            document['mainPic'],
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      // height: MediaQuery.of(context).size.height / 7,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          document['monumentName'].length > 14
                              ? document['monumentName'].substring(0, 14) +
                                  ("...")
                              : document['monumentName'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      )),
                ],
              ),
            )));

        // InkWell(
        //   onTap: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => DetailsPage(detail: document),
        //       ),
        //     );
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child: Container(
        //         color: Colors.black,
        //         height: MediaQuery.of(context).size.height / 6,
        //         width: MediaQuery.of(context).size.width / 3,
        //         child: Center(
        //             child: Text(document['monumentName'],
        //                 style: TextStyle(fontSize: 15)))),
        //   ),
        // ));
      }
    });
    return listy;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listy;
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('monument_details').get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text("Something went wrong, Try again later!",
                    style: TextStyle(color: Colors.black, fontSize: 15)));
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            listy = distance(documents);
            return SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...listy.map((Widget item) => item),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
