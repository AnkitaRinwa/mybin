import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:editable/editable.dart';

class RoutePage extends StatefulWidget {


  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  List rows = [
  { "time":'10:20',"address": 'Ashok Stambh' },
  { "time":'10:30',"address": 'Dana Road',},
  { "time":'10:40',"address": 'Clock Tower',},
  ];
//Headers or Columns
  List headers = [
    {"title":'Time', 'index': 1, 'key':'time',},
  {"title":'Address', 'index': 2, 'key':'address'},

  ];

  var documentId;
  var data;
  String gadi = "no";
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
       gadi = data["Gadino"];
      });
      print(gadi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Container(
            width: 800,
            child:
             gadi==null || gadi == "Requested"?
             Center(child:Text("Gadi is not assigned",style: TextStyle(fontSize: 20,color: Colors.green),)):
             gadi == "no"?
             Expanded(
               flex: 1,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   /// Loader Animation Widget
                   CircularProgressIndicator(
                     valueColor: new AlwaysStoppedAnimation<Color>(
                         Colors.green),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 20.0),
                   ),
                   Text("Please wait ..."),
                 ],
               ),
             ):
      Editable(
        trHeight: 80,
        thSize: 30,
        columns: headers,
        rows: rows,
        showCreateButton: true,
        tdStyle: TextStyle(fontSize: 20),
        showSaveIcon: true, //set true
        borderColor: Colors.grey.shade300,
        columnRatio: 0.4,
          onSubmitted: (value){
          print(value);
        },

        onRowSaved: (value){ //added line
          print(value); //prints to console
        },
      ),
    )
    );
  }
  
}
