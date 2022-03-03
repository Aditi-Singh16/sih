import 'package:flutter/material.dart';
import 'package:sih/backend/firestore_data.dart';
import 'package:sih/backend/models/monument.dart';


class EditMonument extends StatefulWidget {
  const EditMonument({
    required this.monumentIndex,
    Key? key
  }) : super(key: key);
  final String monumentIndex;

  @override
  _EditMonumentState createState() => _EditMonumentState();
}

class _EditMonumentState extends State<EditMonument> {

  //final DataBaseService _databaseService = DataBaseService();
  FirestoreData firestoreData = FirestoreData();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit monument details'
        )
      ),
      body: FutureBuilder<Monument?>(
        future: firestoreData.getMonument(widget.monumentIndex),
        builder: (context, snapshot){
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      Text(
                        snapshot.data!.monumentName,
                        style: const TextStyle(
                          fontSize: 30.0
                        ),
                      ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    const Text(
                        'Add Description',
                        style:TextStyle(
                            fontSize: 22
                        )
                    ),
                    TextFormField(
                      initialValue: snapshot.data!.desc,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 5,

                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                    const Text(
                        'Edit Display Picture',
                        style:TextStyle(
                            fontSize: 22
                        )
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing:10.0,
                        mainAxisSpacing:10.0,
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!.gallery.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Image.network(
                            snapshot.data!.gallery[index],
                            width: width*0.45,
                            height: height*0.1,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('Error');
          }else{
            return const Text('Loading');
          }
        }
      )
    );
  }
}
