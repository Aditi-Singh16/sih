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
        monumentName: result.data()!['monumentName'], 
        category: result.data()!['category'], 
        city: result.data()!['city'], 
        end: result.data()!['end'], 
        state: result.data()!['state'], 
        start: result.data()!['start'], 
        foreigner: result.data()!['foreigner'],
         indian: {
           "adult":result.data()!['indian']['adult'],
            "kid":result.data()!['indian']['kid']
         }, 
         lat: result.data()!['lat'], 
         long: result.data()!['long'], 
         operatorID: result.data()!['operatorID'], 
         rating: result.data()!['rating']
    );
  }

  Future addOrUpdateMonument(Monument monument)async{
    var docId = FirebaseFirestore.instance.collection("feedback").doc();
    await FirebaseFirestore.instance.collection("monument_details").doc(docId.id).set(
        {
          'desc':monument.desc,
          'gallery':monument.gallery,
          'mainPic':monument.mainPic,
          'monumentName':monument.monumentName,
          'foreigner':monument.foreigner,
          'category':monument.category,
          'end':monument.end,
          'indian':monument.indian,
          'lat':monument.lat,
          'long':monument.long,
          'state':monument.state,
          'city':monument.city,
          'rating':monument.rating,
          'operatorID':monument.operatorID,
          'start':monument.start,
          'monumentID':docId.id
        }
        ,SetOptions(merge: true)).then((value) => print("updated"));
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
