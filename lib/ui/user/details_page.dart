import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sih/prefs/sharedPrefs.dart';
import 'package:sih/ui/user/book_ticket.dart';

class DetailsPage extends StatefulWidget {
  DocumentSnapshot detail;
  DetailsPage({required this.detail});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 100),
              child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blueGrey.shade900),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height / 100),
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 100,
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
                        Image.network(widget.detail['gallery'][0]),
                        Image.network(widget.detail['gallery'][1]),
                        Image.network(widget.detail['gallery'][2]),
                        Image.network(widget.detail['gallery'][3]),
                        Image.network(widget.detail['gallery'][4]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      height: MediaQuery.of(context).size.height / 7,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.widgets),
                          Text(
                            "Category",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(widget.detail["category"],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      height: MediaQuery.of(context).size.height / 7,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time_filled),
                          Text(
                            "Opens at",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(widget.detail["start"],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      height: MediaQuery.of(context).size.height / 7,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.access_time_filled),
                          Text(
                            "Closes at",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(widget.detail["end"],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 4.5,
                      height: MediaQuery.of(context).size.height / 7,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star),
                          Text(
                            "Ratings",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(widget.detail["rating"],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: ()async {
                      var id = await HelperFunctions().readUserIdPref();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>BookTickets(
                                foreigner: widget.detail['foreigner'],
                                monumentName: widget.detail['monumentName'], 
                                uid: id,  
                                amountperadult: widget.detail['indian']['adult'], 
                                amountperchild: widget.detail['indian']['kid'], 
                                city: widget.detail['city'], 
                                state: widget.detail['state'],
                                mainPic: widget.detail['mainPic'],
                                operatorID:widget.detail['operatorID']
                                )
                              )
                            );
                    },
                    child: Text("Book Ticket")),
              ],
            ),
            Divider(thickness: 1),
            Center(
              child: Text(widget.detail['monumentName'],
                  style: TextStyle(color: Colors.black)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: const Color(0xffb6daeb),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height / 30,
                  ),
                  child: Text(
                    widget.detail["desc"],
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 22,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
