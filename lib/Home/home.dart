import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybin/Home/Driverinfo.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

var lang = "En";
var theam = "light";

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int setting=0;

  List<String> items = ["Driver Info","Gadi Info","Gadi Location","Assign Gadi"];
  List<String> items1 = ["चालक जानकारी","पगाड़ी जानकारी","गाडी स्थानं","गाडी असाइन करें"];
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return
      Scaffold(
      backgroundColor: theam == "light"?Colors.white:Colors.black,
      appBar: AppBar(
        title: Text( lang == "En"?'My Bins': "मेरा बिन"),
      ),
        drawer: SafeArea(
            child:
            Container(
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
                      lang=="En"?"Settings":"समायोजन",
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
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.language),
                    title: Text(lang=="En"?"Change Language":"भाषा बदलें"),
                  ):Text(""),
                  setting == 1?
                  ListTile(
                    onTap: () {
                      setState(() {
                        theam == "light" ?
                        theam = "dark" :
                        theam = "light";
                      });
                      print("Team is $theam");
                     // Navigator.pop(context);
                    },

                    leading: Icon(Icons.color_lens),
                    title: Text(lang == "En"?"Change Theam":"थीम बदलें"),
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
                    title: Text(lang == "En"?"Help":"मदद"),
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
                    title: Text(lang == "En"?"Contact Us":"संपर्क करें"),
                  ),],
              ),
            )
        ),

      /*drawer: FoldableSidebarBuilder(
       // drawerBackgroundColor: Colors.cyan[100],
        drawer: CustomSidebarDrawer(
          drawerClose: (){
            //_fsbStatus == FSBStatus.FSB_CLOSE?
          setState(() {
            _fsbStatus = FSBStatus.FSB_CLOSE;
          });
           /* :
            setState(() {
              _fsbStatus = FSBStatus.FSB_OPEN;
            });*/
        }
        ),
        //screenContents: Home(),
        status: _fsbStatus,
      ),*/
      body: Center(
        child: ListView.builder(
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
                          MaterialPageRoute(builder: (context) => DriverInfo()),
                              (route) => false):null;
                     /* index==3?
                      _signOut():index==1? Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfile(documentid:documentId, data: data,)),
                              (route) => false):index==2?Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => CallForGadi()),
                              (route) => false):null;*/
                    },

                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios_sharp),
                      onPressed: ()
                      {
                       /* index==0?
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
                                (route) => false):null;*/
                      },
                    ),
                  ));
          },
        ),
      ),

    );
  }
}