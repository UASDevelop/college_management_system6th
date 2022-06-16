import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import 'Models/StDetails.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Students').snapshots();
  GroupController controller = GroupController();
  String v = 'Present';
  String v1 = 'Absent';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administration'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.save)),
        ],
      ),
      body: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return SizedBox(
                      height: 170,
                      width: 200,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        shadowColor: Colors.red.shade50,
                        elevation: 10,
                        clipBehavior: Clip.antiAlias,
                        color: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StudentDetails(data['Roll No'])));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('Name'),
                                    Text(
                                      data['Student Name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                      textAlign: TextAlign.justify,
                                    )
                                    // ,Divider(height: 9)
                                    ,
                                    // Text('Roll No'),
                                    Text(
                                      data['Roll No'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                )),
                            Expanded(
                              child: SimpleGroupedCheckbox<String>(
                                onItemSelected: (val) {
                                  setState(() {
                                    v = val;
                                    v1 = val;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('Attendance')
                                      .doc(data['Roll No'])
                                      .collection('Attendance')
                                      .add({
                                    'Attendace': val,
                                    'Date': DateTime.now()
                                  });
                                },
                                controller: controller,
                                itemsTitle: ["Present", "Absent"],
                                values: [
                                  'Present',
                                  'Absent',
                                ],
                                groupStyle: GroupStyle(
                                    activeColor:
                                        v.contains('Present') && v1 != 'Present'
                                            ? Colors.green
                                            : Colors.red,
                                    itemTitleStyle:
                                        const TextStyle(fontSize: 13)),
                                checkFirstElement: false,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              })),
    );
  }
}
