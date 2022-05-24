import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybin/BotomNavigationPages/Attendance/AttendancePotral.dart';
import 'package:mybin/BotomNavigationPages/Attendance/Leave.dart';
import 'package:mybin/BotomNavigationPages/MyAccount.dart';
import 'package:flutter/cupertino.dart';
import 'package:scratcher/scratcher.dart';
import 'package:intl/intl.dart';

class AttendancePotral extends StatefulWidget {
  final  documentid;
  final  data;

  // In the constructor, require a Person
  AttendancePotral({Key?key, required this.documentid,required this.data}) : super(key: key);

  @override
  _AttendancePotralState createState() => _AttendancePotralState();
}

class _AttendancePotralState extends State<AttendancePotral> {
  double _opacity = 0.0;
  var attendance = [];
  DateTime dates = DateTime.now();

  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      print(widget.data);
      setState(() {
        attendance = widget.data["Attendance"];
      });
      print("Attendance");
      print(attendance);
      if(attendance.length >= 2) {
        //for (var i = 1; i < attendance.length; i++) {
          dates = (DateFormat('MM/dd/yyyy').parse(attendance[attendance.length-1]));
        //}
      }
      print(dates);


     // dates.add(DateFormat('MM/dd/yyyy, hh:mm a').format(attendance.toDate()));

    }
  }

  marek()
  {

    attendance.add(DateFormat('MM/dd/yyyy, hh:mm a').format(DateTime.now()));
    setState(() {
      attendance = attendance;
    });

    var users = FirebaseFirestore.instance.collection('drivers').doc( widget.documentid);
    users
        .update({
      'Attendance': attendance
      //'Mobno': mobno.text,
    })
        .then((value) {print("User Added");
    })
        .catchError((error) => print("Failed to add user: $error"));


  }

  @override
  Widget build(BuildContext context) {



    List items = ["Mark Attendance", "Apply Leave", "Attendance Record"];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: widget.data != null?ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return
            Card(
            color:Colors.green,
            child:
              ListTile(
              title: Text(items[index]),
              onTap: () {
                if (widget.data["Gadino"] == null ||
                    widget.data["Gadino"] == "Requested") {

                  Fluttertoast.showToast(
                    msg: "Gadi is not assigned yet",
                    backgroundColor: Colors.grey,
                    // fontSize: 25
                    gravity: ToastGravity.TOP,
                    // textColor: Colors.pink
                  );
                }
                else {
                  index == 0 ?
                  //dates.contains(DateFormat('MM/dd/yyyy').format(DateTime.now()))?

                  attendance.length != 1 && dates.day == DateTime.now().day && dates.month == DateTime.now().month?
                  Fluttertoast.showToast(
                    msg: "Attendance already marked",
                    backgroundColor: Colors.green,
                    // fontSize: 25
                    gravity: ToastGravity.CENTER,
                    // textColor: Colors.pink
                  )
                      : scratchDialog(context) :
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          LeavePage(data: widget.data,
                              documentid: widget.documentid)),
                          (route) => false);
                }
              },
                trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios_sharp),
            onPressed: ()
            {
              if (widget.data["Gadino"] == null ||
                  widget.data["Gadino"] == "Requested") {

            Fluttertoast.showToast(
            msg: "Gadi is not assigned yet",
            backgroundColor: Colors.green,
            // fontSize: 25
            gravity: ToastGravity.CENTER,
            // textColor: Colors.pink
            );}

              else {
                index == 0 ?
                dates.day == DateTime.now().day && dates.month == DateTime.now().month?
            Fluttertoast.showToast(
            msg: "Attendance already marked",
            backgroundColor: Colors.grey,
            // fontSize: 25
            gravity: ToastGravity.TOP,
            // textColor: Colors.pink
            )
                :scratchDialog(context)
                    :
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        LeavePage(
                            data: widget.data, documentid: widget.documentid)),
                        (route) => false);
              }
            },
                )
            ));
          },
        ):
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
        )
      ),

    );
  }



  /* ###############################Attendance Marked ############################################*/
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
                onScratchEnd: marek,
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
                /*  onEnd: ()
                  {
                    marek();
                  },*/
                  opacity: _opacity,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.2,
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Column(
                      children: [
                        Text("Attendance Mared",style: TextStyle(fontSize: 20),),
                        Expanded(child: Icon(Icons.check_circle,color: Colors.lightGreen,size: 100,))
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