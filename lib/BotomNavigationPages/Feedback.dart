import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mybin/BotomNavigationPages/MyAccount.dart';
import 'package:mybin/loginauth/home.dart';

class FeedbackPage extends StatefulWidget {


  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  List<String> items = ["Driver Rating","Municipal Rating","App Rating"];
  List<String> items1 = ["चालक रेटिंग","नगर रेटिंग","ऐप रेटिंग"];
  double? _ratingValue1;
  double? _ratingValue2;
  double? _ratingValue3;
  TextEditingController messages = TextEditingController();


  Future<void> addUser() {

    var users = FirebaseFirestore.instance.collection('UsersFeedback');
    return users
        .add({
      'DriverRating':_ratingValue3.toString(),
      'MuncipleRating': _ratingValue1.toString(),
      'AppRating': _ratingValue2.toString(),
      'Massage':messages.text,
    })
        .then((value) {print("User Added");
    Fluttertoast.showToast(
      msg: "Feedback Send",
      backgroundColor: Colors.green,
      // fontSize: 25
      gravity: ToastGravity.CENTER,
      // textColor: Colors.pink
    );
    })
        .catchError((error) => print("Error is Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        resizeToAvoidBottomInset: true,
          body:
              Column(
                children: <Widget>[
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return
               Card(
                    color:Colors.white,
                    child:
                    ListTile(
                        title: Text(lang=="En"?items[index]:items1[index]),
                        onTap: (){

                        },
                      subtitle:  RatingBar(
                          initialRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                              full: const Icon(Icons.star, color: Colors.lightGreen),
                              half: const Icon(
                                Icons.star_half,
                                color: Colors.lightGreen,
                              ),
                              empty: const Icon(
                                Icons.star_outline,
                                color: Colors.lightGreen,
                              )),
                          onRatingUpdate: (value) {
                            setState(() {
                              index==0?_ratingValue3=value:index==1?_ratingValue1 = value:_ratingValue2 = value;
                            });
                          }),
                    ));

            },
          ),
        SizedBox(height: 30,),
        Container(
            color:Colors.white,
            height: 80,
            child:
             Flexible(
              child: TextField(
                controller: messages,
                style: TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                ),

             /*   onChanged:(valuem){ message.text = valuem;
                setState(() {
                  message.text = mobno.text;
                });
                },*/
              ),
            ),
        ),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(20.0),
                      child: Text(lang=="EN"?"Submit".toUpperCase():"प्रस्तुत"),
                      onPressed: (){
                        addUser();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyAccount()),
                                (route) => false);

                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                    ),
                  ),
      ]),
      ),

    );
  }
}
