import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sih/backend/models/monument.dart';
import 'package:sih/backend/models/ticketChecker.dart';
import 'package:sih/prefs/sharedPrefs.dart';

class FirestoreData {
  Future<Monument?> getMonument(String operatorID) async {
    Map<String, dynamic> monDet = {};
    var getid = await FirebaseFirestore.instance
        .collection("monument_details")
        .where("operatorID", isEqualTo: operatorID)
        .get();
    getid.docs.forEach((val) {
      monDet = val.data()!;
    });
    return Monument(
        id: monDet['monumentID'],
        desc: monDet['desc'],
        gallery: monDet['gallery'],
        mainPic: monDet['mainPic'],
        monumentName: monDet['monumentName'],
        category: monDet['category'],
        city: monDet['city'],
        end: monDet['end'],
        state: monDet['state'],
        start: monDet['start'],
        foreigner: monDet['foreigner'].toString(),
        indian: {
          "adult": monDet['indian']['adult'],
          "kid": monDet['indian']['kid']
        },
        lat: monDet['lat'],
        long: monDet['long'],
        operatorID: monDet['operatorID'],
        rating: monDet['rating']);
  }

  Future addOrUpdateMonument(Monument monument) async {
    var docId = FirebaseFirestore.instance.collection("monument_details").doc();
    await FirebaseFirestore.instance
        .collection("monument_details")
        .doc(docId.id)
        .set({
      'desc': monument.desc,
      'gallery': monument.gallery,
      'mainPic': monument.mainPic,
      'monumentName': monument.monumentName,
      'foreigner': monument.foreigner,
      'category': monument.category,
      'end': monument.end,
      'indian': monument.indian,
      'lat': monument.lat,
      'long': monument.long,
      'state': monument.state,
      'city': monument.city,
      'rating': monument.rating,
      'operatorID': monument.operatorID,
      'start': monument.start,
      'monumentID': docId.id
    }, SetOptions(merge: true)).then((value) => print("updated"));
  }

  Future addTicketChecker(TicketChecker ticketChecker) async {
    await FirebaseFirestore.instance
        .collection("check_type")
        .add(TicketChecker(
                monumentID: ticketChecker.monumentID,
                name: ticketChecker.name,
                age: ticketChecker.age,
                gender: ticketChecker.gender,
                nationality: ticketChecker.nationality,
                email: ticketChecker.email,
                phone_no: ticketChecker.phone_no,
                type: ticketChecker.type,
                monument_name: ticketChecker.monument_name,
                operatorName: ticketChecker.operatorName)
            .toMap())
        .then((value) => print("added ticket checker"));
  }

  Future<double> getRevenue(String operatorID) async {
    double total = 0.0;
    await FirebaseFirestore.instance
        .collection("tickets_booked")
        .where("operatorID", isEqualTo: operatorID)
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data()!['total_amount']);
        total = total + double.parse(result.data()!['total_amount']);
      });
    });
    print(total);
    return total;
  }

  Future setMonumentDetails(String phone, String type) async {
    HelperFunctions _helperFunctions = HelperFunctions();
    FirebaseFirestore.instance
        .collection("check_type")
        .where("type", isEqualTo: type)
        .where("phone", isEqualTo: phone)
        .get()
        .then((value) {
      value.docs.forEach((result) async {
        print(result.data()!['monument_name']);
        print(result.data()!['monumentID']);
        _helperFunctions.setMonNamePref(result.data()!['monument_name']);
        _helperFunctions.setMonumentIdPref(result.data()!['monumentID']);
        if (type == "ticket_checker") {
          _helperFunctions.setoperatorNamePref(result.data()!['operator_name']);
        }
      });
    });
  }
}
