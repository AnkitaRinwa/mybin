import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybin/Home/home.dart';

class DriverInfo extends StatefulWidget {
  @override
  _DriverInfoState createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var documentId;
  var data;

  void initState() {
    // TODO: implement initState
    super.initState();
    documentId = _auth.currentUser?.phoneNumber.toString();
    CollectionReference users = FirebaseFirestore.instance.collection('drivers');
    var ans = users.snapshots();
    ans.toList().then((value) {
      setState(() {
        data = value;
      });
    });
    print(data);
  }

  //DriverInfo({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Driver Info';

    return MaterialApp(
      //color: theam == "light"?Colors.white:Colors.black,
      title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: theam == "light"?Colors.white:Colors.black,
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return
              Card(
                  color: Colors.green,
                  child:
                  ListTile(
                    title: Text(lang=="En"?"Hello":"Hi"),
                    onTap: (){

                    },

                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios_sharp),
                      onPressed: ()
                      {
                      },
                    ),
                  ));
          },
        ),
      ),
    );
  }
}