import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

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

  runApp(Monu());

}

class Monu extends StatefulWidget{
  @override
  State<Monu> createState() => _MonuState();
}

class _MonuState extends State<Monu> {
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

    double fontSize= MediaQuery.of(context).size.width * 0.05;
    double width = MediaQuery.of(context).size.width;
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
            body:Column(
              children: [
                Column(
                  children: [
                    //space
                    SizedBox(
                      height:  height*0.04,
                    ),
                    //space
                    Center(
                      child:  CarouselSlider(
                        items: [
                          //1st Image of Slider
                          Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(imgList[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          //2nd Image of Slider
                          Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(imgList[1]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          //3rd Image of Slider
                          Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(imgList[2]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          //4th Image of Slider
                          Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(imgList[3]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          //5th Image of Slider
                          Container(
                            margin: EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(imgList[4]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                        //Slider Container properties
                        options: CarouselOptions(
                          height:  height*0.36,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                    ),
                    //space
                    SizedBox(
                      height:  height*0.01,
                    ),
                    //space

                    //monument name
                    Column(
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: Text(
                            monument_name,
                            textAlign: TextAlign.center,
                            style: TextStyle(

                                fontWeight: FontWeight.bold, fontSize: fontSize, height:  height*0.0009),
                          ),
                        ),
                        //space
                        SizedBox(
                          height:  height*0.02,
                        ),
                        //space

                        //blue container
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: Column(
                            children: [

                              Container(

                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[100],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0, bottom: 20.0),

                                child: Column(
                                  children: [
                                    Text(
                                      "Description",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                                    ),

                                    Container(

                                      // adding margin
                                      margin: const EdgeInsets.all(15.0),

                                      // adding padding


                                      // height should be fixed for vertical scrolling
                                      height:  height*0.23,

                                      // SingleChildScrollView should be
                                      // wrapped in an Expanded Widget
                                      child: Column(
                                        children: [
                                          Expanded(

                                            // SingleChildScrollView contains a
                                            // single child which is scrollable
                                            child: SingleChildScrollView(

                                              // for Vertical scrolling
                                              scrollDirection: Axis.vertical,
                                              child: Text(

                                                monument_description,
                                                style: TextStyle(

                                                  fontSize: fontSize,


                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height:  height*0.005,
                              ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 20),
                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.arrow_forward, size: fontSize),
                                      label: Text('Icon Button'),
                                      onPressed: () => {},
                                    ),
                                    SizedBox(width:  width*0.04,),
                                    ElevatedButton.icon(
                                      icon: Icon(Icons.arrow_forward, size: 16),
                                      label: Text('Ticket Checker'),
                                      onPressed: () => {},
                                    ),

                                  ],
                                ),)

                            ],

                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ],
            )

        )
    );
  }
}

