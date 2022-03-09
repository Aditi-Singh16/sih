import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PredictionGraph extends StatelessWidget {
  PredictionGraph(this.seriesList, {this.animate = false});
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool animate;

  factory PredictionGraph.withSampleData() {
    return PredictionGraph(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override



  Widget build(BuildContext context) {
    return Container();
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      TimeSeriesSales(DateTime(2017, 9, 19), 5),
      TimeSeriesSales(DateTime(2017, 9, 26), 25),
      TimeSeriesSales(DateTime(2017, 10, 3), 100),
      TimeSeriesSales(DateTime(2017, 10, 10), 75),
    ];

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
