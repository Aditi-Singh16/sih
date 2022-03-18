import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sih/backend/firestore_data.dart';
import 'package:sih/backend/local_data.dart';
import 'package:sih/backend/models/user.dart';
import 'package:sih/prefs/sharedPrefs.dart';
import 'package:sih/ui/operator/bottom_nav.dart';
import 'package:sih/ui/operator/edit_monument.dart';
import 'package:sih/ui/ticket_checker/bottom_nav.dart';
import 'package:sih/ui/user/bottom_nav.dart';
import 'package:sih/ui/user/home.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  ProfilePage({required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String dropdownvalue = 'User';
  var items = [
    'User',
    'Ticket_Checker',
    'Operator',
  ];

  final _nameController = TextEditingController();

  final _nationController = TextEditingController();

  Future<void> addUser(String name, String nation) async {
    DataBaseHelper dataBaseHelper = DataBaseHelper.instance;
    MyUser insertMyUser = MyUser(
        uid: widget.user.uid,
        name: name,
        phone: widget.user.phoneNumber!,
        nationality: _nationController.text,
        type: dropdownvalue.toLowerCase());
    await dataBaseHelper.insertUser(insertMyUser);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user.uid)
        .set(insertMyUser.toMap());
    HelperFunctions().setUserNamePref(name);
    await FirestoreData().setMonumentDetails(
        widget.user.phoneNumber!, dropdownvalue.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF48CAE4),
        title: Text(
          "Profile Page",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 15),
                Icon(
                  Icons.person_add_alt_outlined,
                  size: 80,
                  color: Color(0xFF0077B6),
                ),
                SizedBox(height: 13),
                Text(
                  "Profile Page",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00B4D8)),
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5)),
                      labelText: "Name",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    controller: _nameController,
                  ),
                ),
                SizedBox(height: 20),
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
                      labelText: "${widget.user.phoneNumber}",
                      enabled: false,
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.map,
                        size: 18,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5)),
                      labelText: "Nationality",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    controller: _nationController,
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      HelperFunctions().setUserIdPref(widget.user.uid);
                      final name = _nameController.text.trim();
                      final nation = _nameController.text.trim();
                      addUser(name, nation).then((value) => {
                            if (dropdownvalue == 'Operator')
                              {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OperatorBottomNavBar()),
                                    (Route<dynamic> route) => false)
                              }
                            else if (dropdownvalue == 'User')
                              {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserBottomNavBar()),
                                    (Route<dynamic> route) => false)
                              }
                            else if (dropdownvalue == 'Ticket_Checker')
                              {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TicketBottomNavBar()),
                                    (Route<dynamic> route) => false)
                              }
                          });
                    },
                    style: ElevatedButton.styleFrom(primary: Color(0xFF00B4D8)),
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
