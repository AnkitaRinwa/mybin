import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybin/BotomNavigationPages/Maptracker.dart';
import 'package:mybin/BotomNavigationPages/MyAccount.dart';
import 'package:mybin/BotomNavigationPages/Route.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

var lang = "En";
var theam = "light";

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int setting=0;

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    //_advancedDrawerController.showDrawer();
  }

  static List<Widget> _pages = <Widget>[

  //MapScreenWidget(),
   Maptracker(),
   /*Icon(
      Icons.chat,
      size: 150,
    ),*/
    RoutePage(),
     MyAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return
      Scaffold(
      backgroundColor: theam == "light"?Colors.white:Colors.black,
      appBar: AppBar(
        title: Text( lang == "En"?'My Bins': "मेरा बिन"),
        /*leading:


        _selectedIndex==0 || _selectedIndex==1?
        IconButton(
            onPressed: _handleMenuButtonPressed,
            icon:Icon(Icons.menu)
        ):
        /*IconButton(onPressed: ()
            {
              setState(() {
                _fsbStatus = _fsbStatus == FSBStatus.FSB_OPEN ?
                FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
              });

            }, icon: Icon(Icons.menu))*/

        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()
          {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
          },
        ),*/
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
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(

        color: Colors.lightGreen,
        buttonBackgroundColor: Colors.lightGreen,
        backgroundColor: Colors.green,
        items: <Widget>[
            Icon(Icons.home),
            //label: 'Home',

         // CurvedNavigationBarItem(
           Icon(Icons.route),
            //label: 'Route',
          //),
         // CurvedNavigationBarItem(
           Icon(Icons.person),
         //   label: 'Account',
        //  ),
          // CurvedNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: 'Chats',
          // ),
        ],
        index: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
  /*String? uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
            },
          )
        ],
      ),
      body: Center(
        child: Text(uid!),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }*/
