import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_system6th/Attandance.dart';
import 'package:college_management_system6th/FeeSection/Fee.dart';
import 'package:college_management_system6th/StdList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Models/courses.dart';
import 'TProfile.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference users = FirebaseFirestore.instance.collection('Students');

  Future<void> deleteUser() {
    return users
        .doc()
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
  List<Courses> list = [Courses('a', 1), Courses('b', 2)];

  int _selectedIndex = 0;
  static  List<Widget> _widgetOptions = <Widget>[
STDLIST(),
    Attendance(),
    Fee(),
   TProfile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:
        _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
                backgroundColor: Colors.green
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_email),
                label: '',
                backgroundColor: Colors.yellow
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.feed),
                label: '',
                backgroundColor: Colors.pink
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.person),
              backgroundColor: Colors.blue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.black,
          iconSize: 40,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}
