import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mybin/BotomNavigationPages/Attendance/AttendancePotral.dart';

class LeavePage extends StatefulWidget {

  final  documentid;
  final  data;

  // In the constructor, require a Person
  LeavePage({Key?key, required this.documentid,required this.data}) : super(key: key);
  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController reason = TextEditingController();

  var leave;

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      leave = widget.data["Leave"];

    });
    if (leave == null) {leave=[];}
    else leave = leave.toList();

    print(leave);
  }

  Future<void> addLeave() {

    leave.add({
      'From': fromDate.text,
      'To': toDate.text,
      'Reason': reason.text,
      'Status':'Applied'
    });
    setState(() {
      leave = leave;
    });

    var users = FirebaseFirestore.instance.collection('drivers').doc(widget.documentid);
    return users
        .update({
      'Leave': leave,
    })
        .then((value) {print("User Added");
    Fluttertoast.showToast(
      msg: "Leave Applied",
      backgroundColor: Colors.green,
      // fontSize: 25
      gravity: ToastGravity.CENTER,
      // textColor: Colors.pink
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) =>
        AttendancePotral(documentid: widget.documentid,data: widget.data,)),
            (route) => false);
    })
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16.0),
                prefixIcon: Container(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(10.0)
                        )
                    ),
                    child: Icon(Icons.calendar_today, color: Colors.lightGreen,)),
                hintText: "From Date",
                hintStyle: TextStyle(color: Colors.lightGreen),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.lightGreen.withOpacity(0.1),


              ),
              controller: fromDate,
              readOnly: true,  //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101)
                );

                if(pickedDate != null ){
                  print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    fromDate.text = formattedDate; //set output date to TextField value.
                  });
                }else{
                  print("Date is not selected");
                }
              },
            ),
            SizedBox(height: 40,),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16.0),
                prefixIcon: Container(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(10.0)
                        )
                    ),
                    child: Icon(Icons.calendar_today, color: Colors.lightGreen,)),
                hintText: "To Date",
                hintStyle: TextStyle(color: Colors.lightGreen),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.lightGreen.withOpacity(0.1),


              ),
              controller: toDate,
              readOnly: true,  //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101)
                );

                if(pickedDate != null ){
                  print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    toDate.text = formattedDate; //set output date to TextField value.
                  });
                }else{
                  print("Date is not selected");
                }
              },
            ),
            SizedBox(height: 50,),
            //Spacer(),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(16.0),
                prefixIcon: Container(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(10.0)
                        )
                    ),
                    child: Icon(Icons.person, color: Colors.lightGreen,)),
                hintText: "Reason for leave",
                hintStyle: TextStyle(color: Colors.lightGreen),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.lightGreen.withOpacity(0.1),


              ),

              validator: (value) {
                value!.isEmpty ? 'Reason cannot be blank' : null;
                //if (value==""||value==null){validateMobile(value);
              },
              //value!.isEmpty ? 'Name cannot be blank' : null,

              onChanged:(value) => reason.text = value,
            ),

            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.white,
                textColor: Colors.lightGreen,
                padding: const EdgeInsets.all(20.0),
                child: Text("Submit".toUpperCase()),
                onPressed: (){
                  addLeave();

                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                ),
              ),
            ),

            leave.length!= null ?
    Expanded(
    child: SizedBox(
    height: 200.0,
    child:
    ListView.builder(
                itemCount: leave.length,
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    tileColor: Colors.lightGreen.shade50,
                      leading: Icon(Icons.list),
                      trailing: Text(leave[index]["Status"],
                        style: TextStyle(
                            color: Colors.green,fontSize: 15),),
                      title:Text(leave[index]["Reason"]),
                    subtitle:
                        Column(
                            children: <Widget>[
                              Row(
                                  children: <Widget>[
                                    Text("From :-    "),
                                    Text(leave[index]["From"]),
                                    ]
                              ),
                              Row(
                                  children: <Widget>[
                                    Text("To:-    "),
                                    Text(leave[index]["To"]),
                                  ]
                              )
                              ]
                        )
                  );
                },
            )
    )) :
                SizedBox(),
            //Spacer(),


          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
