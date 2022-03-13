import 'package:flutter/material.dart';
import 'package:sih/backend/apicalls.dart';
import 'package:sih/ui/operator/prediction_graph.dart';

class ShowGraph extends StatefulWidget {
  const ShowGraph({Key? key}) : super(key: key);

  @override
  State<ShowGraph> createState() => _ShowGraphState();
}

class _ShowGraphState extends State<ShowGraph> {
  final List<String> _daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  int dayNum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictions')
      ),
        body: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                  child: InkWell(
                    onTap: ()async{
                      setState(() {
                          dayNum = index;
                        });
                    },
                    child: Text(_daysOfWeek[index])
                    ),
                );
              },
            ),
          ),
          PredictionGraph(dayOfWeek: dayNum)
        ],
      ),
    ));
  }
}
