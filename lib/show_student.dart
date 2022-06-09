import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Show_Student extends StatefulWidget {
  const Show_Student({Key? key}) : super(key: key);

  @override
  _Show_StudentState createState() => _Show_StudentState();
}

class _Show_StudentState extends State<Show_Student> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Students').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('User')
          .where('deviceId', isEqualTo: device.name!)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(device.name!),
              subtitle: Text(data['email']),
            );
          }).toList(),
        );
      },
    )
  }
}
