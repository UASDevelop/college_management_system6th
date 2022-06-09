import 'package:college_management_system6th/Sign_up.dart';
import 'package:college_management_system6th/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  _Sign_inState createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
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
            textfield(_email, 'email', 'vcdg'),
            textfield(_password, 'password', 'cgsfh'),
            ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _email.text,
                        password: _password.text
                    );
                    if(userCredential.user!=null){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      Fluttertoast.showToast(
                          msg: "This email does not exist!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    } else if (e.code == 'wrong-password') {
                      Fluttertoast.showToast(
                          msg: "Wrong Password",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      print('Wrong password provided for that user.');
                    }

                  }
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
                child: Text('Sign In')),
            Row(
              children: [
                Container(
                  child: Text('Dont hsve account'),
                  margin: EdgeInsets.only(left: 20, right: 20),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Sign_up()));
                    },
                    child: Text('Sign Up'))
              ],
            )
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
