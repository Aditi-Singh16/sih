import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sih/ui/operator/moument_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
String monument_name="";
final List<String> imgList = [
  '',

];
void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ticks());

}

class ticks extends StatefulWidget{
  @override
  State<ticks> createState() => _ticksState();
}

class _ticksState extends State<ticks> {
  Future fun () async {
    var collection = FirebaseFirestore.instance.collection('monument_details');
    collection.doc('64yuabipz6bGugJwuNXv').snapshots().listen((docSnapshot) {
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data()!;
        setState(() {
          monument_name = data['monumentName'];
          imgList[0]=data['mainPic'];


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
    double fontSize= MediaQuery.of(context).size.width * 0.05;
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
            body:Container(
              decoration: BoxDecoration(
                color:const Color(0xffC8E3EF),

              ),
              child:
                Column(

                  children: [
                   SizedBox(
                      height:  height*0.04,
                    ),
                    Column(

                      children: [
                        SizedBox(
                          height:  height*0.04,
                        ),
                        //space
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Image.network(imgList[0],
                              width:width*10,
                              height:height*0.27,)  ),

                        SizedBox(
                          height:  height*0.006,
                        ),
                        //monument name
                        Text(
                          monument_name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: fontSize),
                        ),
                     SizedBox(
                          height:  height*0.01,
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                        ),

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
                                          "Time " + "|",
                                          textAlign: TextAlign.center,
                                          style: TextStyle( fontSize: fontSize),
                                        ),
                                        Text(
                                          "Date ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle( fontSize: fontSize),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Location ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle( fontSize: fontSize),
                                    ),
                                     SizedBox(
                                      height:   height*0.01,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30),
                                        child: Image.network("https://www.investopedia.com/thmb/ZG1jKEKttKbiHi0EkM8yJCJp6TU=/1148x1148/filters:no_upscale():max_bytes(150000):strip_icc()/qr-code-bc94057f452f4806af70fd34540f72ad.png",
                                          width:width*10,
                                          height:height*0.27,)  ),
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
                                      builder: (context) => new Monu())
                                  );
                                },
                              ),

                            ],

                          ),
                        ),

                      ],
                    )

                  ],
                ),

            )

        )
    );
  }
}
