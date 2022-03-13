// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qrscan/qrscan.dart' as scanner;

// import 'package:sih/ui/ticket_checker/successful_scan.dart';

// class TicketCheckerHome extends StatelessWidget {
//   @override
//   Future _qrScanner() async {
//     var cameraStatus = await Permission.camera.status;
//     if (cameraStatus.isGranted) {
//       String? qrdata = await scanner.scan();
//       print(qrdata);
//     } else {
//       var isGrant = await Permission.camera.request();
//       if (isGrant.isGranted) {
//         String? qrdata = await scanner.scan();
//         print(qrdata);
//       }
//     }
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF48CAE4),
//         toolbarHeight: 90,
//         title: Row(
//           children: [
//             SizedBox(width: 25),
//             Text(
//               "ProfilePic",
//               style: TextStyle(fontSize: 20),
//             ),
//             SizedBox(width: 30),
//             Text(
//               "Welcome Zen!",
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(25),
//         child: Center(
//             child: Column(
//           children: [
//             SizedBox(height: 20),
//             Text(
//               "Monument Assigned: 'Taj Mahal'",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Color(0xFF0077B6),
//                 fontFamily: "Libre Baskerville",
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Operator Name: 'Raje Menon'",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Color(0xFF0077B6),
//                 fontFamily: "Libre Baskerville",
//               ),
//             ),
//             SizedBox(height: 40),
//             SizedBox(
//               height: 55,
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   _qrScanner();
//                 },
//                 style: ElevatedButton.styleFrom(primary: Color(0xFF00B4D8)),
//                 child: Text(
//                   'Scan Now',
//                   style: TextStyle(fontSize: 26),
//                 ),
//               ),
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }
