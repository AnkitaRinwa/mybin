
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mybin/BotomNavigationPages/MyAccount.dart';
import 'package:mybin/loginauth/home.dart';
import 'package:mybin/loginauth/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
//import 'package:mybin/wedget/network_image.dart';
class EditProfile extends StatefulWidget {
  @override
  final  documentid;
  final  data;

  // In the constructor, require a Person
  EditProfile({Key?key, required this.documentid,required this.data}) : super(key: key);

  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController mobno = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      setState(() {
        name.text = widget.data["Name"];
        mobno.text = widget.data["Mobno"];
        address.text = widget.data["Address"];
  });
    }

  @override
  Widget build(BuildContext context){

    ScreenUtil.instance = ScreenUtil()..init(context);
    return Material(
      //key: _formKey,
      //resizeToAvoidBottomInset: false,
      color: theam == "light"? Colors.white : Colors.black,
      child:
      Container(
        padding: const EdgeInsets.all(16.0),
        height: double.infinity,
        /*decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.lightGreen,
                  Colors.green
                ]
            )
        ),*/
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
                      hintText:name.text,
                      hintStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.green.withOpacity(0.1),

                    ),


                    /*validator: (valuen) =>
              valuen!.isEmpty ? 'Name cannot be blank' : null,*/
                    onChanged:(valuen) {
                      setState(() {
                        name.text = valuen;
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
                    hintText:mobno.text,
                    enabled: false,
                    hintStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none
                    ),
                    filled: true,
                    fillColor: Colors.green.withOpacity(0.1),
                  ),
                  keyboardType: TextInputType.number,

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
                    hintText: address.text,
                    hintStyle: TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.green.withOpacity(0.1),

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
                    color: Colors.lightGreen,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Save".toUpperCase()),
                    onPressed: (){
                      print(name.text);
                      var users = FirebaseFirestore.instance.collection('drivers').doc("+91"+mobno.text);
                    users
                          .update({
                      'Name': name.text,
                      'Address': address.text,
                      //'Mobno': mobno.text,
                      })
                          .then((value) {print("User Added");
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAccount()),
                      );
                      })
                      .catchError((error) => print("Failed to add user: $error"));

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                  ),
                ),
                //Spacer(),
              ],
            )),
      ),
    );
  }
}
