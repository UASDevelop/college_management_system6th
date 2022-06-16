import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddSub extends StatefulWidget {
  @override
  _AddSubState createState() => _AddSubState();
}

class _AddSubState extends State<AddSub> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoll();
  }
  String? rollno;
  getRoll() async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    setState(() {
      rollno=sharedPreferences.getString('stroll');
    });
  }

  TextEditingController _stdname = TextEditingController();
  TextEditingController _rollno = TextEditingController();
  TextEditingController _contactno = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _department = TextEditingController();

  String stdname = '';
  String Rollno = '';
  String contactno = '';
  String address = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          children: [
            SizedBox(
              height: 70,
            ),
            Center(
                child: Text(
              'ADD Subjects',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
            textfield(_stdname, 'Subject1', 'abc'),
            textfield(_rollno, 'Subject2', 'vcdg'),
            textfield(_contactno, 'Subject3', 'cgsfh'),
            textfield(_address, 'Subject4', 'cgsfh'),
            textfield(_department, 'Subject5', 'depart'),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: Colors.white),
                child: ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Students')
                          .doc(rollno)
                          .update({
                        'Sub1': _stdname.text,
                        'Sub2': _rollno.text,
                        'Sub3': _contactno.text,
                        'Sub4': _address.text,
                        'Sub5': _department.text,
                      });
                      reset();
                    },
                    child: Text('Add Subject')),
              ),
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
      margin: EdgeInsets.only(
        left: 30,
        right: 30,
        bottom: 20,
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: label,
        ),
      ),
    );
  }

  reset() {
    _stdname.clear();
    _rollno.clear();
    _address.clear();
    _contactno.clear();
    _department.clear();
  }
}
