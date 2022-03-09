import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sih/backend/models/monument.dart';
import 'package:sih/backend/models/ticketChecker.dart';

class FirestoreData{

  Future<Monument?> getMonument ()async{
    var result = await FirebaseFirestore.instance.collection("monument_details").doc("64yuabipz6bGugJwuNXv").get();
    print(result.data()!['desc']);
    print(result.id);
    return Monument(
      id: result.id,
        desc: result.data()!['desc'],
        gallery: result.data()!['gallery'],
        mainPic: result.data()!['mainPic'],
        monumentName: result.data()!['monumentName']
    );
  }

  Future addOrUpdateMonument(Monument monument)async{
    await FirebaseFirestore.instance.collection("monument_details").doc("64yuabipz6bGugJwuNXv").set(
        monument.toMap(),SetOptions(merge: true)).then((value) => print("updated"));
  }

  Future addTicketChecker(TicketChecker ticketChecker)async{
    await FirebaseFirestore.instance.collection("users").add(
      TicketChecker(
          id: ticketChecker.id,
          name: ticketChecker.name,
          age: ticketChecker.age,
          gender: ticketChecker.gender,
          nationality: ticketChecker.nationality,
          email: ticketChecker.email,
          phone_no: ticketChecker.phone_no,
        type: ticketChecker.type
      ).toMap()
    ).then((value) => print("added ticket checker"));
  }

}