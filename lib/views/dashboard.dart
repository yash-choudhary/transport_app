import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:transport_app/services/auth_service.dart';
import '../widgets/provider_widget.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:unicorndial/unicorndial.dart';
import '../widgets/add_dialog.dart';
//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:share/share.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  static String uid, email;
  // ignore: missing_return
  Future<String> get_uid() async {
    uid = await Provider.of(context).auth.getCurrentUID();
    email = await Provider.of(context).auth.getCurrentEmail();
  }

  circularIndicator() {
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(
        future: get_uid(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return circularIndicator();
          } else {
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
                            drawer: drawer(context, snapshot, uid, email),
                            floatingActionButton: UnicornDialer(
                                backgroundColor: Color.fromRGBO(255, 255, 255,
                                    0) /*Last parameter is opacity value*/,
                                parentButtonBackground: Colors.redAccent,
                                orientation: UnicornOrientation.VERTICAL,
                                parentButton: Icon(Icons.add),
                                childButtons: childbuttons(context)),
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

Widget drawer(
    BuildContext context, AsyncSnapshot snapshot, String uid, String email) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Row(
            children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 30.0,
                    ),
                  ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: AutoSizeText(
                          getname(snapshot),
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight + Alignment(0, .3),
                      child: Text(
                        getcategory(snapshot),
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight + Alignment(0, .6),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: new Border.all(
                                color: Colors.white, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
            ],
          ),
        ),
        ListTile(
          title: Text('Connections'),
          onTap: () {},
        ),
        ListTile(
          title: Text('SignOut'),
          onTap: () async {
            try {
              AuthService auth = Provider.of(context).auth;
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

String getname(AsyncSnapshot snapshot) {
  try {
    return snapshot.data['name'].toString().toUpperCase();
  } catch (e) {
    print(e);
    return 'null';
  }
}

String getcategory(AsyncSnapshot snapshot) {
  try {
    return snapshot.data['category'].toString().toUpperCase();
  } catch (e) {
    print(e);
    return 'null';
  }
}

List childbuttons(BuildContext context) {
  var childButtons = List<UnicornButton>();

  childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: "Add Transporter",
      currentButton: FloatingActionButton(
        heroTag: "train",
        backgroundColor: Colors.teal,
        mini: true,
        child: Icon(Icons.person_add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => AddDialog(
              title: "Add Transporter",
              description: "Increase your business network!",
              primaryButtonText: "Add",
              primaryButtonRoute: "/signUp",
            ),
          );
        },
      )));
  
  childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: "Share your UID",
      currentButton: FloatingActionButton(
        heroTag: "shareid",
        backgroundColor: Colors.deepOrangeAccent,
        mini: true,
        child: Icon(Icons.share),
        onPressed: () {
          Share.share("Here is my Unique Id:\n${_DashState.uid}");
        },
      )));

  return childButtons;
}
