import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mybin/BotomNavigationPages/Attendance/AttendancePotral.dart';
import 'package:mybin/BotomNavigationPages/Callgadi.dart';
import 'package:mybin/BotomNavigationPages/EditProfile.dart';
import 'package:mybin/BotomNavigationPages/Feedback.dart';
import 'package:mybin/loginauth/home.dart';
import 'package:mybin/loginauth/login.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
 List<String> items = ["Feedback","Edit Profile","Call for gadi","Log Out"];
 List<String> items1 = ["प्रतिपुष्टि","प्रोफ़ाइल संपादित","गाडी के लिए कॉल करें","लॉग आउट"];
 final FirebaseAuth _auth = FirebaseAuth.instance;
 var documentId;
 var data;

 void initState() {
   // TODO: implement initState
   super.initState();
   documentId = _auth.currentUser?.phoneNumber.toString();
   CollectionReference users = FirebaseFirestore.instance.collection('drivers');
   var ans = users.doc(documentId).get();
   ans.then((value) {
     print("printing");

     setState(() {
       data = value.data();
     });
   });
 }

  //MyAccount({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'My Account';

    Future<void> _signOut() async {
     await _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }

    return MaterialApp(
      //color: theam == "light"?Colors.white:Colors.black,
      title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: theam == "light"?Colors.white:Colors.black,
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return
            Card(
              color: Colors.green,
            child:
              ListTile(
              title: Text(lang=="En"?items[index]:items1[index]),
              onTap: (){
                    index==0?
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => FeedbackPage()),
                            (route) => false):
                        index==3?
                        _signOut():index==1? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfile(documentid:documentId, data: data,)),
                                (route) => false):index==2?Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => CallForGadi()),
                                (route) => false):null;
              },

               trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios_sharp),
                  onPressed: ()
                  {
                    index==0?
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => FeedbackPage()),
                            (route) => false):
                    index==3?
                    _signOut():index==1? Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile(documentid:documentId, data: data,)),
                            (route) => false):index==2?Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => CallForGadi()),
                            (route) => false):null;
                  },
                ),
            ));
          },
        ),
      ),
    );
  }
}