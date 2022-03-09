import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sih/ui/user/detailsPage.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({Key? key}) : super(key: key);

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

func(listy, document, context) {
  listy.add(InkWell(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsPage(detail: document),
        ),
      );
    },
    child: Container(
        height: MediaQuery.of(context).size.height / 6,
        child: Center(child: Text(document['monumentName']))),
  ));
}

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
    List<Widget> listy = [
      Text("These are the recommended nearby place",
          style: TextStyle(color: Colors.black, fontSize: 10)),
      SizedBox(
        height: 20,
      )
    ];
    documents.forEach((DocumentSnapshot document) {
      lat = document['lat'];
      long = document['long'];
      dist = getDist(userLat, userLong, lat, long);
      if (dist <= 100000) {
        setState(() {
          func(listy, document, context);
        });
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
            return ListView(
              children: [
                ...listy.map((Widget item) => item),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  double getDist(double userLat, double userLong, double lat, double long) {
    return Geolocator.distanceBetween(userLat, userLong, lat, long);
  }
}
