import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sih/backend/firestore_data.dart';

class BlurryDialog extends StatefulWidget {
  BlurryDialog(
      {required this.ticketInfo, Key? key})
      : super(key: key);

  @override
  State<BlurryDialog> createState() => _BlurryDialogState();
  final Map<String, dynamic> ticketInfo;
}

class _BlurryDialogState extends State<BlurryDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("Ticket details")
        ),
        body:  Center(
          child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lottie.network(
                  "https://assets9.lottiefiles.com/packages/lf20_smcd09k7.json"),
                    Text(
                        "Ticket booked on ${widget.ticketInfo['date']} at ${widget.ticketInfo['time']}",
                        style: TextStyle(color: Colors.black,fontSize: 15)
                        ),
                    Text("Total Amount paid: ${widget.ticketInfo['total_amount']}"
                    , style: TextStyle(color: Colors.black,fontSize: 15)
                    ),
                    Text(
                        "Tickets booked for ${widget.ticketInfo['members'].length} members",
                         style: TextStyle(color: Colors.black,fontSize: 15)
                        ),
                    SizedBox(height: 20),
                    Text(
                      'Details',
                      style: TextStyle(color: Colors.black)
                      ),
                    SingleChildScrollView(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.ticketInfo['members'].length,
                        itemBuilder: (context,index){
                          return Card(
                            color: Color(0xff48CAE4),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1597058712635-3182d1eacc1e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8aW5kaWFuJTIwZmxhZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60")
                              ),
                                title:Text(widget.ticketInfo['members'][index]['name']),
                              subtitle:Text(widget.ticketInfo['members'][index]['age'])
                            ),
                          );
                        }),
                    ),
                    ElevatedButton(onPressed: ()async {
                      await FirestoreData().grantAccess(widget.ticketInfo['uid']);
                    }, child: Text('Grant Access'))
                  ],
                ),
            ),
          ),
        ),
    );
  }
}
