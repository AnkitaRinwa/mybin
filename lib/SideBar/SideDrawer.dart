/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybin/loginauth/home.dart';

class CustomSidebarDrawer extends StatefulWidget {

  final Function drawerClose;

  const CustomSidebarDrawer({Key? key, required this.drawerClose}) : super(key: key);

  @override
  _CustomSidebarDrawerState createState() => _CustomSidebarDrawerState();
}

class _CustomSidebarDrawerState extends State<CustomSidebarDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int setting=0;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.lightGreen[300],
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images.png",
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text( _auth.currentUser!.phoneNumber.toString())
                ],
              )),
          ListTile(
            onTap: (){
              setState(() {
                setting == 0 ?
                    setting = 1 :
                    setting = 0;
              });
            },
            leading: Icon(Icons.settings),
            title: Text(
              "Settings",
            ),
          ),
          setting == 1?
          ListTile(
            onTap: () {
              setState(() {
                lang == "Hi"?
                lang = "En":
                lang = "Hi";
              });
            },
            leading: Icon(Icons.language),
            title: Text("Change Language"),
          ):Text(""),
          setting == 1?
          ListTile(
            onTap: () {
              setState(() {
                theam == "light" ?
                theam = "dark" :
                theam = "light";
              });
            },
            leading: Icon(Icons.color_lens),
            title: Text("Change Theam"),
          ):Text(""),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("");
            },
            leading: Icon(Icons.help),
            title: Text("Help"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),

          ListTile(
            onTap: () {
              debugPrint("Tapped Log Out");
            },
            leading: Icon(Icons.contacts),
            title: Text("Contact Us"),
          ),
        ],
      ),
    );
  }
}*/