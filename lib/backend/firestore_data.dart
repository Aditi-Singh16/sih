import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sih/backend/models/monument.dart';

class FirestoreData{

  Future<Monument?> getMonument (String index)async{
    var result = await FirebaseFirestore.instance.collection("monument_details").doc("64yuabipz6bGugJwuNXv").get();
    return Monument(
        desc: result.data()![index]['description'],
        gallery: result.data()![index]['gallery'],
        mainPic: result.data()![index]['main_pic'],
        monumentName: result.data()![index]['name']
    );
  }

  Future addOrUpdateMonument(Monument monument)async{
    await FirebaseFirestore.instance.collection("monument_details").doc("64yuabipz6bGugJwuNXv").set(
        {"Monument_1": monument.toMap()},SetOptions(merge: true)).then((value) => print("updated"));
  }
}