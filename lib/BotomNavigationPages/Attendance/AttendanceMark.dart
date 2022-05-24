import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class AttendanceMark extends StatefulWidget {
  @override
  _AttendanceMarkState createState() => _AttendanceMarkState();
}

class _AttendanceMarkState extends State<AttendanceMark> {
  double _opacity = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String datetime = DateTime.now().toString();
  var documentId;
  var data;
  var attendance;
  void initState() {
    // TODO: implement initState
    super.initState();
    documentId = _auth.currentUser?.phoneNumber.toString();
    CollectionReference users = FirebaseFirestore.instance.collection('drivers');
    var ans = users.doc(documentId).get();
    ans.then((value) {
      print("printing");
      data = value.data();
      setState(() {
       attendance = data["Attendance"];
      });
      print(attendance);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FlatButton(
          onPressed: (){

            var users = FirebaseFirestore.instance.collection('drivers').doc(documentId);
            users
                .update({
              'Attendance': "Requested",
              //'Mobno': mobno.text,
            })
                .then((value) {print("User Added");
            })
                .catchError((error) => print("Failed to add user: $error"));


            scratchDialog(context);
          },
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          color: Colors.cyan[300],
          child: Text("Scratch Card",
            style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20),),

        ),
      ),
    );
  }

  Future<void> scratchDialog(BuildContext context) {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Attendance Marker",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 25),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return Scratcher(
                color: Colors.lightGreen,
                accuracy: ScratchAccuracy.low,
                threshold: 30,
                brushSize: 40,
                onThreshold: () {
                  setState(() {
                    _opacity = 1;
                  });
                },
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: _opacity,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Column(
                      children: [
                        Text("Attendance Mared",style: TextStyle(fontSize: 20),),
                        Expanded(child: Image.asset("assets/gift.png",))
                      ],
                    ),
                  ),
                ),

              );
            }),
          );
        }
    );
  }
}