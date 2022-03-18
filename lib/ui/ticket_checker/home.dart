import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:sih/backend/firestore_data.dart';
import 'package:sih/prefs/sharedPrefs.dart';
import 'package:sih/ui/ticket_checker/showdet.dart';

class TicketCheckerHome extends StatefulWidget {
  @override
  State<TicketCheckerHome> createState() => _TicketCheckerHomeState();
}

class _TicketCheckerHomeState extends State<TicketCheckerHome> {
  var name = '';
  var opname = '';
  var monAssign = '';
  Map<String, dynamic> ticketInfo = {};
  setInf() async {
    HelperFunctions _helperFunctions = HelperFunctions();
    String resname = await _helperFunctions.readUserNamePref();
    String resopname = await _helperFunctions.readOpNamePref();
    String resmonAssign = await _helperFunctions.readMonumentNamePref();
    setState(() {
      name = resname;
      opname = resopname;
      monAssign = resmonAssign;
    });
  }

  @override
  void initState() {
    setInf();
    super.initState();
  }

  @override
  Future _qrScanner() async {
    var cameraStatus = await Permission.camera.status;
    FirestoreData firestoreData = FirestoreData();
    if (cameraStatus.isGranted) {
      String? qrdata = await scanner.scan();
      print("qrdata isss");
      print(qrdata);
      if (qrdata!.length > 0) {
        print("yellooo");
        Map<String, dynamic> ticketRes =
            await firestoreData.getTicketDetails(qrdata.split("_")[0]);
        print(ticketRes);
        setState(() {
          ticketInfo = ticketRes;
        });
      }
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        String? qrdata = await scanner.scan();
        print("qrdata isss");
        if (qrdata!.length > 0) {
          print("yellooo");
          Map<String, dynamic> ticketRes =
              await firestoreData.getTicketDetails(qrdata.split("_")[0]);
          print(ticketRes);
          setState(() {
            ticketInfo = ticketRes;
          });
        }
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF48CAE4),
        title: Text(
          "Welcome " + name + "!",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Monument Assigned: $monAssign",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0077B6),
                fontFamily: "Libre Baskerville",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Operator Name: $opname",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0077B6),
                fontFamily: "Libre Baskerville",
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _qrScanner();
                if (ticketInfo.isNotEmpty) {
                  print("uoo");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BlurryDialog(ticketInfo: ticketInfo)));
                }
              },
              style: ElevatedButton.styleFrom(primary: Color(0xFF00B4D8)),
              child: Text(
                'Scan Now',
                style: TextStyle(fontSize: 26),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
