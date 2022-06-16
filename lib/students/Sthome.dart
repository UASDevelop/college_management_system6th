import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_management_system6th/students/stAttendence.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/StDetails.dart';
import '../Models/courses.dart';
import 'StProfile.dart';
import 'StResult.dart';

class StHome extends StatefulWidget {
  @override
  _StHomeState createState() => _StHomeState();
}

class _StHomeState extends State<StHome> {
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
  static List<Widget> _widgetOptions = <Widget>[Studentpro(), StAttendence(),StResult()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
                backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_email),
                label: '',
                backgroundColor: Colors.yellow),
            BottomNavigationBarItem(
                icon: Icon(Icons.feed),
                label: '',
                backgroundColor: Colors.pink),
          ],
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.black,
          iconSize: 40,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
