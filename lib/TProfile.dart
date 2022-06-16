import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sign_in.dart';

class TProfile extends StatefulWidget {

  @override
  _TProfileState createState() => _TProfileState();
}

class _TProfileState extends State<TProfile> {

  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 70,
            ),
          )
        ],
      ),
    );
  }
}
