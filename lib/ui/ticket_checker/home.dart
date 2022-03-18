import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:sih/prefs/sharedPrefs.dart';

class TicketCheckerHome extends StatefulWidget {
  @override
  State<TicketCheckerHome> createState() => _TicketCheckerHomeState();
}

class _TicketCheckerHomeState extends State<TicketCheckerHome> {
  var name = '';

  setInf() async {
    HelperFunctions _helperFunctions = HelperFunctions();
    String resname = await _helperFunctions.readUserNamePref();
    setState(() {
      name=resname;
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
    if (cameraStatus.isGranted) {
      String? qrdata = await scanner.scan();
      print("qrdata isss");
      print(qrdata);
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        String? qrdata = await scanner.scan();
        print("qrdata isss");
        print(qrdata);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF48CAE4),
        title: Text(
          "Welcome "+name+"!",
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
              "Monument Assigned: 'Taj Mahal'",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0077B6),
                fontFamily: "Libre Baskerville",
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Operator Name: 'Raje Menon'",
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0077B6),
                fontFamily: "Libre Baskerville",
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _qrScanner();
                },
                style: ElevatedButton.styleFrom(primary: Color(0xFF00B4D8)),
                child: Text(
                  'Scan Now',
                  style: TextStyle(fontSize: 26),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
