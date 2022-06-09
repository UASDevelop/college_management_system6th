import 'package:college_management_system6th/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  TextEditingController _name=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  String name='';
  String email='';
  String password='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          children: [
           textfield(
          _name,'Name','abc'

        ),
            textfield(
                _email,'email','vcdg'
            ), textfield(
                _password,'password','cgsfh'
            ),
           ElevatedButton(onPressed: ()async{
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
          FirebaseAuth auth=FirebaseAuth.instance;
          await auth.createUserWithEmailAndPassword(email: _email.text, password: _password.text);
           }, child: Text('Create Account'))
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
    ){
    return Container(
      margin: EdgeInsets.only(left: 30,right: 30, bottom: 20,top: 20),
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
