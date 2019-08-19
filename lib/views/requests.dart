import 'package:flutter/material.dart';
import 'package:transport_app/services/auth_service.dart';
import '../widgets/provider_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/user_model.dart';

class RequestsPage extends StatefulWidget {
  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
//  static String uid, email;
//  static QuerySnapshot qs;
//  // ignore: missing_return
//  Future<String> get_uid() async {
//    uid = await Provider.of(context).auth.getCurrentUID();
//    //qs = await Firestore.instance.collection('users').document(uid).collection('friendrequests').getDocuments();
//  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.of(context).pushReplacementNamed('/home');
          }),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("users")
              .document(usermodel.uid)
              .collection("friendrequests")
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
                        color: docsnap['type'] == 'sent'
                            ? Colors.blueGrey
                            : Colors.teal,
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: ListTile(
                        onTap: (){
                          return null;
                        },
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          title: AutoSizeText(
                            docsnap['name'].toString().toUpperCase(),
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,),
                          ),
                          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                          subtitle: Row(
                            children: <Widget>[
                              Text(docsnap['category'].toString().toUpperCase(),
                                  style: TextStyle(color: Colors.white70,))
                            ],
                          ),
                          trailing: docsnap['type'] == 'sent'
                              ? Text("SENT",style: TextStyle(color: Colors.lightGreen,fontWeight: FontWeight.bold)):IconButton(
                            icon: Icon(Icons.person_add),
                            color: Colors.white,
                            onPressed: () {},
                          )),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
