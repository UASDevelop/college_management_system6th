import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Add_Student extends StatefulWidget {
  const Add_Student({Key? key}) : super(key: key);

  @override
  _Add_StudentState createState() => _Add_StudentState();
}

class _Add_StudentState extends State<Add_Student> {
  TextEditingController _stdname=TextEditingController();
  TextEditingController _rollno=TextEditingController();
  TextEditingController _contactno=TextEditingController();
  TextEditingController _address=TextEditingController();
  TextEditingController _department=TextEditingController();
  String stdname='';
  String rollno='';
  String contactno='';
  String address='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Form(
        child: ListView(
          children: [
            textfield(
                _stdname,'Name','abc'

            ),
            textfield(
                _rollno,'Roll No','vcdg'
            ),
            textfield(
                _contactno,'Contact No','cgsfh'
            ),
            textfield(
                _address,'Address','cgsfh'
            ),
            textfield(
                _department,'enroll','depart'
            ),
            ElevatedButton(onPressed: (){
              FirebaseFirestore.instance.collection('Students').add({
                'Student Name': _stdname.text,
                'Roll No': _rollno.text,
                'Contact No': _contactno.text,
                'Address': _address.text,
                'Department': _department.text,
              });
              reset();

            }, child: Text('Submit'))
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
  reset(){
    _stdname.clear();
    _rollno.clear();
    _address.clear();
    _contactno.clear();
    _department.clear();
  }
  }

