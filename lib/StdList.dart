import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/StDetails.dart';
import 'add_student.dart';

class STDLIST extends StatefulWidget {
  const STDLIST({Key? key}) : super(key: key);

  @override
  _STDLISTState createState() => _STDLISTState();
}

class _STDLISTState extends State<STDLIST> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Students').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Administration'),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Add_Student()));
            },
            icon: Icon(Icons.add)),
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
        if(!snapshot.hasData){
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
                    borderRadius: BorderRadius.circular(5)
                ),
                child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          StudentDetails(data['Roll No'])
                      ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name'),
                        Text(data['Student Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.justify,)
                        ,Divider(height: 9)

                        ,Text('Roll No'),
                        Text(data['Roll No'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        ListTile(
                          trailing: Icon(Icons.delete),
                        ),
                      ],
                    )
                ),
              ),
            );
          }).toList(),
        );
      })),
    );
  }
}
