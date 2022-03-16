// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sih/backend/firestore_data.dart';
import 'package:sih/prefs/sharedPrefs.dart';
import 'package:sih/ui/operator/bottom_nav.dart';
import 'package:sih/ui/operator/prediction_graph.dart';

class ShowGraph extends StatefulWidget {
  const ShowGraph({Key? key}) : super(key: key);

  @override
  State<ShowGraph> createState() => _ShowGraphState();
}

class _ShowGraphState extends State<ShowGraph> {
  final List<String> _daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat','Sun'];
  int dayNum = 0;
  String avg = '';
  double tot = 0.0;
  setAvg() async {
    avg = await HelperFunctions().readAvgPeoplePref();
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: PredictionGraph(dayOfWeek: dayNum),
            ),
            Padding(
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
                          Text(avg.length > 0 ? avg : '...')
                        ],
                      ),
                      Row(
                        children: [
                          Text('Total Revenue ',
                              style: TextStyle(fontSize: 15)),
                          Spacer(),
                          Text(tot.toString()+' Rs'),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
