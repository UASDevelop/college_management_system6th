import 'package:college_management_system6th/Sign_up.dart';
import 'package:college_management_system6th/add_student.dart';
import 'package:college_management_system6th/show_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/courses.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Courses> list=[Courses('a', 1),Courses('b', 2)];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administration'),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Student()));
          }, icon: Icon(Icons.add)),
        ],
      ),
      body: Container(
       child: ListView.builder(
         itemCount: list.length,
         itemBuilder: (BuildContext context, index){
           return Container(
             child: ListTile(title: Text(list[index].cname),
             subtitle: ElevatedButton(onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>Show_Student()));
             },
             child: Text("${list[index].cid}")),),
           );
         }
       )
      ),
    );
  }
}
