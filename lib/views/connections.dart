import 'package:flutter/material.dart';
import 'package:transport_app/services/auth_service.dart';
import '../widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/user_model.dart';
import '../services/conn_mgmt.dart';
import '../views/profileview.dart';

class ConnectionsPage extends StatefulWidget {
  @override
  _ConnectionsPageState createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {

  circularIndicator() {
    return Scaffold(
      backgroundColor: Colors.white70,
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
    return WillPopScope(
        onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Connections"),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.of(context).pushReplacementNamed('/home');
          }),
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection("users")
                .document(usermodel.uid)
                .collection("friends")
                .snapshots(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                circularIndicator();
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot docsnap = snapshot.data.documents[index];
                    return Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            //gradient: LinearGradient(colors: [Colors.blue[500],Colors.blue[400],Colors.blue[300],Colors.blue[200],Colors.blue[100]]),
                            boxShadow: [BoxShadow(color: Colors.black45)]
                        ),
                        child: ListTile(
                            onTap: (){
                              Profile.profileviewer(docsnap['uid'],context);
                            },
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            title: AutoSizeText(
                              docsnap['name'].toString().toUpperCase(),
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,),
                            ),
                            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                            subtitle: Row(
                              children: <Widget>[
                                Text(docsnap['category'].toString().toUpperCase(),
                                    style: TextStyle(color: Colors.black45,))
                              ],
                            ),
                            ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
