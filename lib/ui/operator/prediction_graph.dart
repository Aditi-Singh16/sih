import 'package:flutter/material.dart';
import 'package:sih/backend/apicalls.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PredictionGraph extends StatefulWidget {
  const PredictionGraph({this.dayOfWeek = 0, Key? key}) : super(key: key);
  final int dayOfWeek;

  @override
  State<PredictionGraph> createState() => _PredictionGraphState();
}

class _PredictionGraphState extends State<PredictionGraph> {
  List<int> Pred = [10, 20, 30, 40, 50, 60, 45, 34, 44];

  @override
  void initState() {
    print("in initState");
    print(widget.dayOfWeek);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
        future: GetNumberOfPeople().fetchCrowdNumber("Agra", widget.dayOfWeek),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          } else if (snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.5,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Crowd Prediction'),
                  legend: Legend(isVisible: true),
                  series: <LineSeries<CrowdData, String>>[
                    LineSeries<CrowdData, String>(
                        dataSource: <CrowdData>[
                          CrowdData('9am', snapshot.data![0]),
                          CrowdData('10am', snapshot.data![1]),
                          CrowdData('11am', snapshot.data![2]),
                          CrowdData('12pm', snapshot.data![3]),
                          CrowdData('1pm', snapshot.data![4]),
                          CrowdData('2pm', snapshot.data![5]),
                          CrowdData('3pm', snapshot.data![6]),
                          CrowdData('4pm', snapshot.data![7]),
                          CrowdData('5pm', snapshot.data![8])
                        ],
                        xValueMapper: (CrowdData crowd, _) => crowd.hour,
                        yValueMapper: (CrowdData crowd, _) => crowd.numberOfpeople,
                        dataLabelSettings: const DataLabelSettings(isVisible: true))
                  ]),
            );
          }
          return SpinKitFadingCube(
              color: Color(0xFF48CAE4),
              size: 50.0,
            );
        });
  }
}

class CrowdData {
  CrowdData(this.hour, this.numberOfpeople);
  final String hour;
  final int numberOfpeople;
}
