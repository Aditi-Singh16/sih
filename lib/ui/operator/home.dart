import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OperatorHome extends StatefulWidget{

  @override
  State<OperatorHome> createState() => _OperatorHomeState();
}

class _OperatorHomeState extends State<OperatorHome> {

  
  @override

  Widget build(BuildContext context){

    double fontSize= MediaQuery.of(context).size.width * 0.04;
    double height = MediaQuery.of(context).size.height;

    return MaterialApp(

        home: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff48CAE4),
              title: const Text('Monument detail'),
              leading: IconButton(icon:Icon(Icons.arrow_back_rounded,color: Colors.white),
                onPressed:() => Navigator.pop(context, false),
              ),
            ),
            backgroundColor: Colors.white,
            body:StreamBuilder(
              stream: FirebaseFirestore.instance.collection('monument_details')
                  .where('operatorID',isEqualTo: "I0YIVmKZYAYUJ2rHhvIFDOelmF43").snapshots(),
              builder: (context, AsyncSnapshot snapshot){
                if(snapshot.hasError){
                  return const Text("error");
                }else if(snapshot.hasData){
                  final specificDocument = snapshot.data.docs;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: specificDocument.length,
                      itemBuilder: (context,snap){
                        return Column(
                          children: [
                            //space
                            Container(
                              margin: EdgeInsets.all(MediaQuery.of(context).size.height / 100),
                              height: MediaQuery.of(context).size.height*0.5,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Carousel(
                                boxFit: BoxFit.cover,
                                autoplay: true,
                                animationCurve: Curves.fastOutSlowIn,
                                animationDuration: Duration(milliseconds: 600),
                                dotSize: 6.0,
                                dotIncreasedColor: Color(0xff48CAE4),
                                dotBgColor: Colors.transparent,
                                dotPosition: DotPosition.bottomCenter,
                                dotVerticalPadding: 10.0,
                                showIndicator: true,
                                borderRadius: true,
                                indicatorBgPadding: 7.0,
                                images: [
                                  Image.network(snapshot.data.docs[snap]['gallery'][0]),
                                  Image.network(snapshot.data.docs[snap]['gallery'][1]),
                                  Image.network(snapshot.data.docs[snap]['gallery'][2]),
                                  Image.network(snapshot.data.docs[snap]['gallery'][3]),
                                  Image.network(snapshot.data.docs[snap]['gallery'][4]),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:  height*0.005,
                            ),
                            //monument name
                            Text(
                              snapshot.data.docs[snap]['monumentName'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: fontSize),
                            ),

                            SizedBox(
                              height:  height*0.009,
                            ),
                            //space
                            Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color:const Color(0xffb6daeb),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                              ),

                              child: Column(
                                children: [
                                  SizedBox(
                                    height:  height*0.007,
                                  ),
                                  Text(
                                    "Description",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                                  ),
                                  SizedBox(
                                    height:  height*0.01,
                                  ),
                                  Container(

                                    alignment: Alignment.bottomCenter,
                                    // adding margin
                                    margin:  EdgeInsets.only(top:height*0.001,left:height*0.05,right:height*0.05),
                                    // height should be fixed for vertical scrolling
                                    height: height*0.4,
                                    // SingleChildScrollView should be
                                    // wrapped in an Expanded Widget
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          // SingleChildScrollView contains a
                                          // single child which is scrollable
                                          child: SingleChildScrollView(
                                            // for Vertical scrolling
                                            scrollDirection: Axis.vertical,
                                            child: Text(
                                              snapshot.data.docs[snap]['desc'],
                                              style: TextStyle(

                                                fontSize: fontSize ,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:  height*0.04,
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                          children: [
                                            ElevatedButton(

                                              onPressed: () {},
                                              child: Text(
                                                "         Edit         ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text(
                                                "Ticket Checker",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height:  height*0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
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
