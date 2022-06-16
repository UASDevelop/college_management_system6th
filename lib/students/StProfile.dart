import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddSubject.dart';

class Studentpro extends StatefulWidget {


  @override
  _StudentproState createState() => _StudentproState();
}

class _StudentproState extends State<Studentpro>{
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
  var size = SizedBox(
    height: 40,
  );
  var dbstyle = const TextStyle(fontSize: 20, color: Colors.blue);
  var style =
  TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Students')
        .where('Roll No',isEqualTo: rollno)
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (!snapshot.hasData) {
              return Text('Does not exist code');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      size,
                      Center(
                        child: CircleAvatar(
                          radius: 90,
                        ),
                      ),
                      size,
                      Text(
                        'Course ID=>',
                        style: style,
                      ),
                      size,
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(children: [
                            Text(
                              'Name',
                              style: style,
                            ),
                            Text(
                              data['Student Name'],
                              style: dbstyle,
                            )
                          ]),
                          TableRow(children: [
                            Text(
                              'Roll No',
                              style: style,
                            ),
                            Text(
                              data['Roll No'],
                              style: dbstyle,
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Department',
                              style: style,
                            ),
                            Text(
                              data['Department'],
                              style: dbstyle,
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Contact',
                              style: style,
                            ),
                            Text(
                              data['Contact No'],
                              style: dbstyle,
                            ),
                          ]),
                          TableRow(children: [
                            Text(
                              'Address',
                              style: style,
                            ),
                            Text(
                              data['Address'],
                              style: dbstyle,
                            ),
                          ])
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(left: 200,bottom: 10),
      child: FloatingActionButton(
        isExtended: true,
        clipBehavior: Clip.antiAlias,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddSub()));
        },
      child: Icon(Icons.add),
      ),
    ),
    );

  }
}
