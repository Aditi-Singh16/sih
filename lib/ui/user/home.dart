import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sih/prefs/sharedPrefs.dart';
import 'package:sih/ui/user/ListPlaces.dart';
import 'package:sih/ui/user/recommendation.dart';

class UserHome extends StatefulWidget {
  UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  late Position _currentPosition;
  String _currentAddress = "";

  var name, uid;

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

  getInfo() async {
    HelperFunctions _helperFunctions = HelperFunctions();
    uid = await _helperFunctions.readUserIdPref();
    name = await _helperFunctions.readUserNamePref();
    print(uid);
    print(name);
  }

  @override
  void initState() {
    getInfo();
    super.initState();
    _getCurrentLocation();
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
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
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
                                      Text("Hello, ${name}"),
                                      // Text("Hello ${user!.displayName}"),
                                      SizedBox(height: 10),
                                      Row(children: [
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
                                      ])
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3.5,
                            child: Recommendations(),
                          ),
                        ],
                      ),
                    ),
                  )
                              ],
                            ),
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
