import 'package:college_management_system6th/home.dart';
import 'package:college_management_system6th/sign_in.dart';
import 'package:college_management_system6th/students/Stsign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
      children: [
 SizedBox(height: 200,) ,

        Image.asset('image/logo.jfif'),
        SizedBox(height: 100,) ,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Sign_in()));
          }
          ,child: Text('Teacher'),
          ),
          RaisedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>StSign_in()));
          }
            ,child: Text('Student'),
          ),
        ],
        )
      ],
      ),
    );
  }
}
