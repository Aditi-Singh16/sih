import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih/authentication/signup.dart';
import 'package:sih/authentication/user_profile.dart';
import 'package:sih/ui/operator/edit_monument.dart';

import 'backend/local_data.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);


  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {


  String type = '';
  getType()async{
    var uid = FirebaseAuth.instance.currentUser!.uid;
    String res = await DataBaseHelper.instance.getUsersById(uid);
    setState(() {
      type=res;
    });
  }

  @override
  void initState() {
    getType();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,AsyncSnapshot<User?> snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }else if (snapshot.connectionState == ConnectionState.active
            || snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            if(type=='user'){
              //return user home
            }else if(type=='ticket_checker'){
              //return tickerchecker home
            }else if(type=='operator'){
              return EditMonument();
            }
              return ProfilePage(user: snapshot.data!);
          } else {
            return SignUpPage();
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );



  }
}
