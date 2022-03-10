import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sih/ui/user/ListPlaces.dart';
import 'package:sih/ui/user/Recommendation.dart';

class UserHome extends StatefulWidget {
  UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final userID = "64yuabipz6bGugJwuNXv";
  late Position _currentPosition;
  String _currentAddress = "";

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
      print(_currentAddress);
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('categories').get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text("Something went wrong, Try again later!",
                    style: TextStyle(color: Colors.black, fontSize: 15)));
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Scaffold(
                body: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 3.7,
                        width: MediaQuery.of(context).size.width,
                        color: Theme.of(context).bottomAppBarColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width / 16,
                              vertical: MediaQuery.of(context).size.height / 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height:
                                            MediaQuery.of(context).size.height /
                                                25),
                                        Text("Hello UserName"),
                                        SizedBox(height: 10),
                                        InkWell(
                                          onTap:
                                            _getCurrentLocation(),
                                          child: Row(children: [
                                            Icon(Icons.location_on_outlined,
                                                color: Colors.white70),
                                            if (_currentAddress != null)
                                              Text(
                                                _currentAddress,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 10.0),
                                              child: Icon(
                                                  CupertinoIcons.chevron_down,
                                                  color: Colors.white70),
                                            )
                                          ]),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context).size.height /
                                              25),
                                      width:
                                      MediaQuery.of(context).size.height / 12,
                                      height:
                                      MediaQuery.of(context).size.height / 12,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/profile.png'),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ]),
                              SizedBox(height: 20),
                            ],
                          ),
                        )),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Categories",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3.5,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                children: documents
                                    .map((doc) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ListPlaces(
                                              category: doc['title']),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                2,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height /
                                                6,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    doc['image'],
                                                  ),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  2,
                                              color: Colors.black,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(5.0),
                                                child: Text(doc['title'],
                                                    textAlign:
                                                    TextAlign.center),
                                              )),
                                        ],
                                      ),
                                    )))
                                    .toList(),
                              ),
                            ),
                            Text(
                              "Nearby Places",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height / 5,
                            //   child: Recommendations(),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey,
            ),
          );
        });
  }
}