import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';

String monument_name="";
String monument_description="";
final List<String> imgList = [
  '',
  '',
  '',
  '',
  '',
];

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Ticketdetails());

}

class Ticketdetails extends StatefulWidget{

  @override
  State<Ticketdetails> createState() => _TicketdetailsState();
}

class _TicketdetailsState extends State<Ticketdetails> {
  String uid = "I0YIVmKZYAYUJ2rHhvIFDOelmF43";
  GlobalKey globalKey = new GlobalKey();
  Future fun () async {
    var collection = FirebaseFirestore.instance.collection('monument_details');
    collection.doc('64yuabipz6bGugJwuNXv').snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        setState(() {
          monument_name = data['monumentName'];
          monument_description=data['desc'];
          imgList[0]=data['gallery'][0];
          imgList[1]=data['gallery'][1];
          imgList[2]=data['gallery'][2];
          imgList[3]=data['gallery'][3];
          imgList[4]=data['gallery'][4];
        });
        // You can then retrieve the value from the Map like this:

      }
    });
  }
  @override
  void initState() {
    super.initState();
    fun();

  }

  Widget build(BuildContext context){

    double fontSize= MediaQuery.of(context).size.width * 0.04;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(

        home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff48CAE4),
              title: const Text('Ticket detail'),
              leading: IconButton(icon:Icon(Icons.arrow_back_rounded,color: Colors.white),
                onPressed:() => Navigator.pop(context, false),
              ),
            ),
            backgroundColor: Colors.white,
            body:StreamBuilder(
              stream: FirebaseFirestore.instance.collection('tickets_booked')
                  .where('uid',isEqualTo: "I0YIVmKZYAYUJ2rHhvIFDOelmF43").snapshots(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasError){
                  return const Text("error");
                }else if(snapshot.hasData){
                  final specificDocument = snapshot.data.docs;
                  return Container(
                    decoration: BoxDecoration(
                      color:const Color(0xffC8E3EF),

                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: specificDocument.length,
                        itemBuilder: (context,snap){
                          return Column(
                            children: [
                              SizedBox(
                                height:  height*0.04,
                              ),
                              //space
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: Image.network( snapshot.data.docs[snap]['image'],
                                    width:width*10,
                                    height:height*0.27,)  ),
                              SizedBox(
                                height:  height*0.006,
                              ),
                              //monument name
                              Text(
                                snapshot.data.docs[snap]['monument_name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: fontSize),
                              ),
                              SizedBox(
                                height:  height*0.01,
                              ),
                              //space
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                              Container(

                                child: Column(
                                  children: [

                                    Container(


                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                snapshot.data.docs[snap]['time']+" " + "|",
                                                textAlign: TextAlign.center,
                                                style: TextStyle( fontSize: fontSize),
                                              ),
                                              Text(
                                                snapshot.data.docs[snap]['date']+" " ,
                                                textAlign: TextAlign.center,
                                                style: TextStyle( fontSize: fontSize),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            snapshot.data.docs[snap]['location'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle( fontSize: fontSize),
                                          ),
                                          SizedBox(
                                            height:   height*0.01,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 30),
                                            child: RepaintBoundary(
                                              key: globalKey,
                                              child: QrImage(
                                                data: uid,
                                                size: height*0.27,
                                              ),
                                            ),  ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                    ),
                                    OutlineButton(
                                      child: new Text("Cancel Ticket"),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(context, new MaterialPageRoute(
                                            builder: (context) => new Ticketdetails())
                                        );
                                      },
                                    ),

                                  ],

                                ),
                              ),


                            ],
                          );
                        },
                      ),
                    ),
                  );
                }else{
                  return const Text("loading");
                }
              },
            )
        )
    );
  }
}

