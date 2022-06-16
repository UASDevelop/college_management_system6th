import 'package:college_management_system6th/Sign_up.dart';
import 'package:college_management_system6th/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Sthome.dart';

class StSign_in extends StatefulWidget {
  @override
  StSign_inState createState() => StSign_inState();
}

class StSign_inState extends State<StSign_in> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          children: [
            textfield(_email, 'Name', 'Enter Email'),
            textfield(_password, 'Roll No', 'Enter Password'),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 50,
                width: 100,
                child: ElevatedButton(
                    onPressed: () async {
                      SharedPreferences shared =
                          await SharedPreferences.getInstance();
                      shared.setString('stroll', _password.text);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => StHome()));
                      // FirebaseAuth auth = FirebaseAuth.instance;
                      // var user = await auth.signInWithEmailAndPassword(
                      //     email: _email.text, password: _password.text);
                      // if (user != null) {
                      //
                      // } else {
                      //
                      //   print('User not exist!');
                      // }
                    },
                    child: Text('Review')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Text Field
  Widget textfield(
    TextEditingController _controller,
    String label,
    String hint,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 20),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
        ),
      ),
    );
  }
}
