import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sih/ui/user/details_page.dart';

class ListPlaces extends StatelessWidget {
  String category;
  ListPlaces({required this.category});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('monument_details')
            .where('category', isEqualTo: category)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Scaffold(
                    body: Center(
                        child: Text(
                            "Something went wrong, please try again later!"))));
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: Text("Places in $category")),
              body: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    return Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Card(
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.height / 100),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                                color: Colors.black54,
                                width:
                                MediaQuery.of(context).size.height / 400)),
                        color: Colors.white,

                        //margin: EdgeInsets.only(left: 12.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsPage(detail: doc),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.all(
                                      MediaQuery.of(context).size.width / 33),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      doc['mainPic'],
                                      fit: BoxFit.cover,
                                      height:
                                      MediaQuery.of(context).size.height /
                                          3,
                                      width: MediaQuery.of(context).size.width /
                                          2.6,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                              .size
                                              .height /
                                              30),

                                      // child: InkWell(
                                      //   onTap: (){
                                      //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LatestPostDetails(snapshot[index])));
                                      //   },

                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                .size
                                                .height /
                                                150),
                                        child: Text(
                                          doc['monumentName'],
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  50,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            50),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                              .size
                                              .height /
                                              50),
                                      child: Text(
                                        doc['desc'],
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height /
                                                65,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                        MediaQuery.of(context).size.height /
                                            50),
                                    Row(
                                      children: [
                                        Icon(Icons.star, size: 12),
                                        Text("Ratings: ${doc['rating']}/5",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Icon(Icons.description_rounded,
                                            size: 12),
                                        Text("View Details",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }
          return Scaffold(
              body:
              Center(child: CircularProgressIndicator(color: Colors.grey)));
        });
  }
}
