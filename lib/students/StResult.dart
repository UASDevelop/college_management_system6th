import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StResult extends StatefulWidget {
  @override
  _StResultState createState() => _StResultState();
}

class _StResultState extends State<StResult> {
  var subst =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  var markst =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);

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
        .collection('Students')
        .where('Roll No', isEqualTo: rollno)
        .snapshots();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'Result',
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
                    // var t = data['Date'].toString();

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
                                  'Sub1',
                                  style: subst,
                                ),
                                Text(
                                  data['Sub1'],
                                  style: markst,
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  'Sub2',
                                  style: subst,
                                ),
                                Text(
                                  data['Sub2'],
                                  style: markst,
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  'Sub3',
                                  style: subst,
                                ),
                                Text(
                                  data['Sub3'],
                                  style: markst,
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  'Sub4',
                                  style: subst,
                                ),
                                Text(
                                  data['Sub4'],
                                  style: markst,
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  'Sub5',
                                  style: subst,
                                ),
                                Text(
                                  data['Sub5'],
                                  style: markst,
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
