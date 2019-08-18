import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:transport_app/services/auth_service.dart';
import '../widgets/provider_widget.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:unicorndial/unicorndial.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  String uid,email;
  // ignore: missing_return
  Future<String> get_uid() async {
    uid = await Provider.of(context).auth.getCurrentUID();
    email = await Provider.of(context).auth.getCurrentEmail();
  }

  circularIndicator(){
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Item 1",
        currentButton: FloatingActionButton(
          heroTag: "train",
          backgroundColor: Colors.redAccent,
          mini: true,
          child: Icon(Icons.train),
          onPressed: () {},
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Item 1",
        currentButton: FloatingActionButton(
            heroTag: "airplane",
            backgroundColor: Colors.greenAccent,
            mini: true,
            child: Icon(Icons.airplanemode_active))));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Item 1",
        currentButton: FloatingActionButton(
            heroTag: "directions",
            backgroundColor: Colors.blueAccent,
            mini: true,
            child: Icon(Icons.directions_car))));
    return FutureBuilder(
        future: get_uid(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return circularIndicator();
          }else{
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder(
                  stream: Firestore.instance
                      .collection("users")
                      .document(uid)
                      .snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return circularIndicator();
                    if (snapshot.hasData) {
                      return WillPopScope(
                          onWillPop: () async {
                            SystemChannels.platform
                                .invokeMethod('SystemNavigator.pop');
                            return false;
                          },
                          child: Scaffold(
                            appBar: AppBar(
                              title: Text('Dashboard'),
                            ),
                            drawer: drawer(context,snapshot,uid,email),
                            floatingActionButton: UnicornDialer(
                                backgroundColor: Color.fromRGBO(255, 255, 255, 0)/*Last parameter is opacity value*/,
                                parentButtonBackground: Colors.redAccent,
                                orientation: UnicornOrientation.VERTICAL,
                                parentButton: Icon(Icons.add),
                                childButtons: childButtons) ,
                          ));
                    }
                  });
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // ignore: missing_return
                return Text('Error!');
              }
            }
          }
        });
  }
}

Widget drawer(BuildContext context,AsyncSnapshot snapshot, String uid, String email){
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  child: Icon(Icons.person),
                  radius: 30.0,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  getname(snapshot),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0),
                ),
              ),
              Align(
                alignment: Alignment.centerRight +
                    Alignment(0, .3),
                child: Text(
                  getcategory(snapshot),
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight +
                    Alignment(0, .6),
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      border: new Border.all(color: Colors.white,style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0),
                    child: Text(
                      email,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {},
        ),
        ListTile(
          title: Text('SignOut'),
          onTap: () async {
            try {
              AuthService auth =
                  Provider
                      .of(context)
                      .auth;
              Navigator.pop(context);
              await auth.signOut();
              print("Signed Out!");
            } catch (e) {
              print(e);
            }
          },
        ),
      ],
    ),
  );
}

String getname(AsyncSnapshot snapshot){
  try {
    return snapshot.data['name'].toString().toUpperCase();
  }
  catch(e){
    print(e);
    return 'null';
  }
}

String getcategory(AsyncSnapshot snapshot){
  try {
    return snapshot.data['category'].toString().toUpperCase();
  }
  catch(e){
    print(e);
    return 'null';
  }
}