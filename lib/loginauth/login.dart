import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mybin/Register/register.dart';
import 'package:mybin/loginauth/otp.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  var doc;
  get_data(documentId)
  {

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var ans = users.doc(documentId).get();
   ans.then((value) {
     print("printing");
     print(value.data());
     setState(() {
       doc = value.data();});
     });

   return doc;

   /* return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Done");
        }

        return Text("loading");
      },
    );*/
  }
//To retrieve the string
  //String documentID = await get_data();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
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
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 10, left: 10),
              child: TextField(

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
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+91'),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none
                  ),
                ),
                maxLength: 10,
                keyboardType: TextInputType.number,
                controller: _controller,
                /*InputDecoration(
                  hintText: 'Phone Number',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+91'),
                  ),
                ),*/

              ),
            )
          ]),
          Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: RaisedButton(
              color: Colors.white,
              textColor: Colors.lightGreen,
              padding: const EdgeInsets.all(20.0),
              onPressed: () async {
              /* Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OTPScreen(_controller.text))
               );*/
                var phonenumber = '+91'+_controller.text;
                CollectionReference users = FirebaseFirestore.instance.collection('users');
                var ans = users.doc(phonenumber).get();
                ans.then((value) {
                  print("printing");
                  print(value.data());
                  setState(() {
                    doc = value.data();});
                });

                Future.delayed(Duration(seconds: 5), (){
              print("Document value is:- $doc");
              if(doc == null)
                {
                Fluttertoast.showToast(
                msg: "Not Register Create account",
                backgroundColor: Colors.grey,
                // fontSize: 25
                 gravity: ToastGravity.TOP,
                // textColor: Colors.pink
                );}


              else{
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OTPScreen(_controller.text)));
              }
                });
                //String documentID = await get_data(doc_ref);
               // print(documentID);
               /* Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OTPScreen(_controller.text)));*/
              },
              child: Text(
                'Next',
                style: TextStyle(color: Colors.lightGreen),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("haven't account",style: TextStyle(color:Colors.white ),),
              SizedBox(
                height: 20,
                width: 10,
              ),
              RaisedButton(
                color: Colors.white,
                textColor: Colors.lightGreen,
                padding: const EdgeInsets.all(20.0),
                child: Text("REGISTER".toUpperCase()),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registerpage()),
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
        ],
      ),
    ));
  }
}