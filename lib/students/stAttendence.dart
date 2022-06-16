import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StAttendence extends StatefulWidget {
  @override
  _StAttendenceState createState() => _StAttendenceState();
}

class _StAttendenceState extends State<StAttendence> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoll();
  }

  String? rollno;
  getRoll() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      rollno = sharedPreferences.getString('stroll');
    });
  }

  var size = SizedBox(
    height: 40,
  );
  var dbstyle = const TextStyle(fontSize: 16, color: Colors.blue);
  var style = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('Attendance')
        .doc(rollno)
        .collection('Attendance')
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'Attendance',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  shrinkWrap: true,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    var t = data['Date'].toString();

                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Table(
                            border: TableBorder.all(color: Colors.black),
                            children: [
                              TableRow(children: [
                                Text(
                                  data['Date'].toDate().toString(),
                                  style: style,
                                ),
                                Text(
                                  data['Attendace'],
                                  style: dbstyle,
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),
        ],
      ),
    );
  }
}
