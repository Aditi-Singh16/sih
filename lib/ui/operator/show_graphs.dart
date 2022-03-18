// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sih/backend/apicalls.dart';
import 'package:sih/backend/firestore_data.dart';
import 'package:sih/prefs/sharedPrefs.dart';

class ShowGraph extends StatefulWidget {
  final day;
  ShowGraph({required this.day});

  @override
  State<ShowGraph> createState() => _ShowGraphState(day: day);
}

class _ShowGraphState extends State<ShowGraph> {
  final day;
  _ShowGraphState({required this.day});
  final List<String> _daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  late int dayNum = day;

  String avg = '';
  double tot = 0.0;
  setAvg() async {
    double res = await FirestoreData()
        .getRevenue(await HelperFunctions().readUserIdPref());
    setState(() {
      tot = res;
    });
  }

  @override
  void initState() {
    setAvg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predictions')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.09,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _daysOfWeek.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              dayNum = index;
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => ShowGraph(day: index),
                                ),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: dayNum == index
                                ? Colors.blue[300]
                                : Colors.blue[900],
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                          child: Text(_daysOfWeek[index])));
                },
              ),
            ),
            FutureBuilder(
              future: GetNumberOfPeople().fetchCrowdNumber("Agra", dayNum),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text('eroor');
                } else if (snapshot.hasData) {
                  print(snapshot.data);
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF48CAE4),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Average Number of people visiting today',
                                    style: TextStyle(fontSize: 15)),
                                Spacer(),
                                Text(snapshot.data,
                                    style: TextStyle(fontSize: 15))
                              ],
                            ),
                            Row(
                              children: [
                                Text('Total Revenue ',
                                    style: TextStyle(fontSize: 15)),
                                Spacer(),
                                Text(tot.toString() + ' Rs',
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ],
                        )),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: SpinKitFadingCube(
                    color: Color(0xFF48CAE4),
                    size: 50.0,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
