/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybin/loginauth/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
//import 'package:mybin/wedget/network_image.dart';
class Registerpage extends StatefulWidget {
  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final _formKey = GlobalKey<FormState>();
  //static final String path = "lib/src/pages/login/login5.dart";
  //CollectionReference users = FirebaseFirestore.instance.collection('users');
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController mobno = TextEditingController();
  //String address1 = "";
  String name1 ="";
  //String mobno1 = "";
  var imageUrl;








  /*String name = "";
  String address = "";
  String mobno = "";*/



  /*Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'name': name, // John Doe
      'mobileno': mobno, // Stokes and Sons
      'address': address // 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }*/
  String validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
    if (value!.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return "";
  }

  @override
  Widget build(BuildContext context){

    ScreenUtil.instance = ScreenUtil()..init(context);
  
    Future<void> addUser() {

      var users = FirebaseFirestore.instance.collection('users').doc("+91"+mobno.text);
      print(users);
      print("Printing");
      print(name.text);
      print(mobno.text);
      // Call the user's CollectionReference to add a new user
      return users
          .set({
        'Name': name.text,
        'Address': address.text,
        'Mobno': mobno.text,
      })
          .then((value) {print("User Added");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
        })
          .catchError((error) => print("Failed to add user: $error"));
    }
    return Material(
      //key: _formKey,
      //resizeToAvoidBottomInset: false,
      child:
      Container(
        padding: const EdgeInsets.all(16.0),
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.lightGreen,
                  Colors.green
                ]
            )
        ),
        child:
            SingleChildScrollView(
            child:
        Column(
          children: <Widget>[

            Container(
              //color: Colors.white54,
              width: ScreenUtil.instance.setWidth(200),
              height: ScreenUtil.instance.setHeight(200),
            ),
           /* Container(
                margin: const EdgeInsets.only(top: 40.0,bottom: 20.0),
                height: 80,
                child: PNetworkImage(foodLogo)),*/
            Text("MY  BIN".toUpperCase(), style: TextStyle(
                color: Colors.white70,
                fontSize: 24.0,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 40.0),
            TextField(
              //controller: name,
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
                    child: Icon(Icons.account_circle_rounded, color: Colors.lightGreen,)),
                hintText: "enter your name",
                hintStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),

              ),


              /*validator: (valuen) =>
              valuen!.isEmpty ? 'Name cannot be blank' : null,*/
              onChanged:(valuen) { name1 = valuen;
              setState(() {
                name.text = name1;
              });

              }

            ),
            SizedBox(height: 10.0),
            TextField(
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
                    child: Icon(Icons.phone, color: Colors.lightGreen,)),
                hintText: "enter your mobile number",
                hintStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
              ),
                keyboardType: TextInputType.number,
                /*validator: (valuem) =>
                valuem!.isEmpty ? 'Mobile Number cannot be blank' : null,*/
                onChanged:(valuem){ mobno.text = valuem;

                print(mobno.text);
                setState(() {
                  mobno.text = mobno.text;
                });
                },
              //controller: mobno,
              maxLength: 10,


              //controller: mobno,

            ),
            SizedBox(height: 10.0),
            TextField(
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
                    child: Icon(Icons.home_filled, color: Colors.lightGreen,)),
                hintText: "enter your address",
                hintStyle: TextStyle(color: Colors.white54),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),

              ),
             //controller: address,
             /* validator: (value) =>
              value!.isEmpty ? 'Address cannot be blank' : null,*/
              onChanged:(value) { address.text = value;
             setState(() {
               address.text = address.text;
             });
    },
            ),
            SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.white,
                textColor: Colors.lightGreen,
                padding: const EdgeInsets.all(20.0),
                child: Text("Register".toUpperCase()),
                onPressed: (){
                  print(name.text);
                  addUser();

                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                ),
              ),
            ),
            //Spacer(),
            SizedBox(height: ScreenUtil.instance.setHeight(250),),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("If already registered ?",style: TextStyle(color:Colors.white ),),
                SizedBox(
                  height: 20,
                  width: 10,
                ),
                RaisedButton(
                  color: Colors.white,
                  textColor: Colors.lightGreen,
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Login".toUpperCase()),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                  ),
                ),
                /*FlatButton(
                  textColor: Colors.white70,
                  child: Text("Login".toUpperCase()),
                  onPressed: (){},
                ),*/
                /*Container(
                  color: Colors.white54,
                  width: 2.0,
                  height: 20.0,
                ),
                FlatButton(
                  textColor: Colors.white70,
                  child: Text("Forgot Password".toUpperCase()),
                  onPressed: (){},
                ),*/

              ],),
            SizedBox(height: 10.0),
          ],
        )),
      ),
    );
  }
}

/*class Datas {
  final String address;
  final String name;
  final String mobno;


  Datas({required this.name, required this.mobno, required this.address});

  Map<String, dynamic> toMap() {
    return {
      'Address':address,
      'Name': name,
      'Mobno': mobno,

    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Datas{ Address: $address,Name: $name, Mobno: $mobno }';
  }
}*/

