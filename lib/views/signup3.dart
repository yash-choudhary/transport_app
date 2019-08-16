import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard.dart';
import '../widgets/provider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class signup3 extends StatefulWidget {
  final usermodel user;
  signup3({Key key, @required this.user}) : super(key: key);

  @override
  _signup3State createState() => _signup3State();
}

class _signup3State extends State<signup3> {
  final db = Firestore.instance;
  String coll;
  String name_controller,cin_controller,gstin_controller,contactno_controller,address_controller,pincode_controller;
//  TextEditingController name_controller = new TextEditingController();
//
//  TextEditingController cin_controller = new TextEditingController();
//
//  TextEditingController gstin_controller = new TextEditingController();
//
//  TextEditingController contactno_controller = new TextEditingController();
//
//  TextEditingController address_controller = new TextEditingController();
//
//  TextEditingController pincode_controller = new TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
          centerTitle: true,
        ),
        body: Center(
            child: Form(
              key: formkey,
              child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.8, 0.0, 0.8, 0.0),
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  //key: key,
                  decoration: InputDecoration(
                      labelText: 'Company Name',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
                      fillColor: Colors.white70),
                  onSaved: (value) => name_controller = value,
                  autofocus: false,
                  obscureText: false,
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.fromLTRB(0.8, 0.0, 0.8, 0.0),
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  //key: key,
                  decoration: InputDecoration(
                      labelText: 'CIN',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
                      fillColor: Colors.white70),
                  onSaved: (value) => cin_controller = value,
                  autofocus: false,
                  obscureText: false,
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.fromLTRB(0.8, 0.0, 0.8, 0.0),
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  //key: key,
                  decoration: InputDecoration(
                      labelText: 'GSTIN',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
                      fillColor: Colors.white70),
                  onSaved: (value) => gstin_controller = value,
                  autofocus: false,
                  obscureText: false,
                ),
              ),
            ),Padding(
              padding: const EdgeInsets.fromLTRB(0.8, 0.0, 0.8, 0.0),
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  //key: key,
                  decoration: InputDecoration(
                      labelText: 'Contact Number',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
                      fillColor: Colors.white70),
                  onSaved: (value) => contactno_controller = value,
                  autofocus: false,
                  obscureText: false,
                ),
              ),
            ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  child: TextFormField(
                    //key: key,
                    decoration: InputDecoration(
                        labelText: "Address",
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
                        fillColor: Colors.white70),
                    onSaved: (value)=> address_controller=value,
                    autofocus: false,
                    maxLines: null,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.8, 0.0, 0.8, 0.0),
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: TextFormField(
                  //key: key,
                  decoration: InputDecoration(
                      labelText: 'Pin Code',
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
                      fillColor: Colors.white70),
                  onSaved: (value) => pincode_controller = value,
                  autofocus: false,
                  obscureText: false,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
              Container(
                  child: new Column(children: <Widget>[
                    ButtonTheme(
                      minWidth: 200.0,
                      height: 40.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.blue,
                  child: new Text('Submit',style: TextStyle(fontSize: 18.0, color: Colors.white),),
                  onPressed: () async {
                      widget.user.name = name_controller;
                      widget.user.cin = cin_controller;
                      widget.user.gstin = gstin_controller;
                      widget.user.contact = int.parse(contactno_controller);
                      widget.user.address = address_controller;
                      widget.user.pincode = int.parse(pincode_controller);
//              if(widget.user.type==1){
//                coll='fleet_owner';
//              }else if(widget.user.type==2){
//                coll='freight_owner';
//              }else{
//                coll='transporter';
//              }
                    final auth = Provider.of(context).auth;
                    print(auth.getCurrentUser());
                      await db.collection('users').document(auth.getCurrentUser()).setData({
                        'name': name_controller,
                        'type': widget.user.type,
                        'cin': cin_controller,
                        'gstin': gstin_controller,
                        'contact_no': int.parse(contactno_controller),
                        'address': address_controller,
                        'pincode': int.parse(pincode_controller)
                      });
                      print("Updated");
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Dash()));
                  },
                ),
                    )
              ]))
          ],
        ),
            )));
  }
}
