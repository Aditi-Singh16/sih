import 'package:flutter/material.dart';
import 'package:sih/backend/firestore_data.dart';
import 'package:sih/backend/models/ticketChecker.dart';
import 'package:sih/prefs/sharedPrefs.dart';
import 'package:sih/ui/operator/bottom_nav.dart';


class AddTicketChecker extends StatelessWidget {
  AddTicketChecker({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phoneno = TextEditingController();
  FirestoreData firestoreData = FirestoreData();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
       resizeToAvoidBottomInset: false,

      appBar: AppBar(
        title: const Text(
          'Add ticket checker'
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: height*0.03,),
            Text(
                'Add ticket checker',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color:  Color(0xff48CAE4)
              ),
            ),
            SizedBox(height: height*0.02,),
            Center(
              child: Container(
                height: height*0.6,
                width: width*0.9,
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _name,
                        decoration: const InputDecoration(
                            labelText:'Name',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5)
                            )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: width*0.03,),
                      TextFormField(
                        controller: _age,
                        decoration: const InputDecoration(
                            labelText:'Age',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5)
                            )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: width*0.03,),
                      TextFormField(
                        controller: _gender,
                        decoration: const InputDecoration(
                            labelText:'Gender',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5)
                            )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: width*0.03,),
                      TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(
                            labelText:'Email',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5)
                            )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: width*0.03,),
                      TextFormField(
                        controller: _phoneno,
                        decoration: const InputDecoration(
                            labelText:'Phone number',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 5)
                            )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: width*0.03,),
                      ElevatedButton(
                        onPressed: ()async{
                          var ticketMonId = await HelperFunctions().readMonumentIdPref();
                          var ticketmonName = await HelperFunctions().readMonumentNamePref();
                          var ticketOpName = await HelperFunctions().readUserNamePref();
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            TicketChecker newTicketChecker = TicketChecker(
                                monumentID: ticketMonId,
                                monument_name: ticketmonName,
                                operatorName: ticketOpName,
                                type:"ticket_checker",
                                name: _name.text,
                                age: _age.text,
                                gender: _gender.text,
                                nationality: "Indian",
                                email: _email.text,
                                phone_no: _phoneno.text
                            );
                            await firestoreData.addTicketChecker(newTicketChecker).then((value){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Ticket checker Added successfully')),
                              );
                            });
      
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // bottomNavigationBar: OperatorBottomNavBar(),
    );
  }
}
