import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:mybin/loginauth/home.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallForGadi extends StatefulWidget {
  @override
  _CallForGadiState createState() => _CallForGadiState();
}

class _CallForGadiState extends State<CallForGadi> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lang=="En"?'Call For Gadi':"गाडी के लिए कॉल"),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color:Colors.lightGreen[50],
              child: ListTile(
                //leading: Icon(Icons.add),
                title: Text('Name',textScaleFactor: 1.5,),
                trailing: Icon(Icons.call),
                subtitle: Text('9636504673'),
                //selected: true,
                onTap: () async {
                  await FlutterPhoneDirectCaller.callNumber("09636504673");
                },
              ),
            ),
          ),
          //Text(txt,textScaleFactor: 2,)
        ],
      ),
    );
  }
}
