import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih/ui/Login/home_page.dart';
import 'package:sih/ui/user/profile_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String dropdownvalue = 'User';

  var items = [
    'User',
    'Ticket_Checker',
    'Operator',
  ];

  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future signUpUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          UserCredential result = await _auth.signInWithCredential(credential);

          User? user = result.user;

          if (user != null) {
            if (dropdownvalue == 'User') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(
                            user: user,
                          )));
            } else if (dropdownvalue == 'Ticket_Checker') {
              var result = await FirebaseFirestore.instance
                  .collection("users")
                  .where("type", isEqualTo: "ticket_checker")
                  .where("phone_no", isEqualTo: phone)
                  .get();
              if (result.docs.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                              user: user,
                            )));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              }
            }
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (Exception exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: Text("Confirm"),
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);

                        UserCredential result =
                            await _auth.signInWithCredential(credential);

                        User? user = result.user;

                        if (user != null) {
                          if (dropdownvalue == 'User') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                          user: user,
                                        )));
                          } else if (dropdownvalue == 'Ticket_Checker') {
                            var result = await FirebaseFirestore.instance
                                .collection("users")
                                .where("type", isEqualTo: "ticket_checker")
                                .where("phone_no", isEqualTo: phone)
                                .get();
                            if (result.docs.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                            user: user,
                                          )));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            }
                          }
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
          print(verificationId);
          print("Timeout");
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Timeout!"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF48CAE4),
        toolbarHeight: 90,
        title: Row(
          children: [
            SizedBox(width: 25),
            Text(
              "Login",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(width: 50),
            Container(
              padding: EdgeInsets.only(bottom: 13.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2.2,
                  ),
                ),
              ),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 18),
                Icon(
                  Icons.person_add_alt_outlined,
                  size: 80,
                  color: Color(0xFF0077B6),
                ),
                SizedBox(height: 13),
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00B4D8)),
                ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        size: 18,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5)),
                      labelText: "Phone",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    controller: _phoneController,
                  ),
                ),
                SizedBox(height: 20),
                DropdownButton(
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),

                SizedBox(height: 25),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final phone = _phoneController.text.trim();
                      signUpUser(phone, context);
                    },
                    style: ElevatedButton.styleFrom(primary: Color(0xFF00B4D8)),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Have an Account? ",
                //       style: TextStyle(fontSize: 14),
                //     ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Text(
                //         "Login",
                //         style:
                //             TextStyle(fontSize: 14, color: Color(0XFF0077B6)),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
