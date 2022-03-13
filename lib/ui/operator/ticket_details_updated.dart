import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:sih/prefs/sharedPrefs.dart';

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

  runApp(Ticket_Details());

}

class Ticket_Details extends StatefulWidget{

  @override
  State<Ticket_Details> createState() => _Ticket_DetailsState();
}

class _Ticket_DetailsState extends State<Ticket_Details> {
  String uid = "";
  getInfo() async {
    HelperFunctions _helperFunctions = HelperFunctions();
    uid =await _helperFunctions.readUserIdPref();

  }
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  GlobalKey globalKey = new GlobalKey();



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
                  .where('uid',isEqualTo: uid).snapshots(),
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
                                            builder: (context) => new Ticket_Details())
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

