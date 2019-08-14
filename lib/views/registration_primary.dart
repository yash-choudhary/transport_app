import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard.dart';

class Registration extends StatefulWidget {
  final usermodel user;
  Registration({Key key, @required this.user}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final db = Firestore.instance;

  String coll;

  TextEditingController name_controller = new TextEditingController();

  TextEditingController cin_controller = new TextEditingController();

  TextEditingController gstin_controller = new TextEditingController();

  TextEditingController contactno_controller = new TextEditingController();

  TextEditingController address_controller = new TextEditingController();

  TextEditingController pincode_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
          centerTitle: true,
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            txtfield('Company Name', name_controller, true, false),
            txtfield('CIN', cin_controller, false, false),
            txtfield('GSTIN', gstin_controller, false, false),
            txtfield('Contact Number', contactno_controller, false, false),
            maxtxtfield('Address', address_controller, false),
            txtfield('Pin Code', pincode_controller, false, false),
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
                    widget.user.name = name_controller.text;
                    widget.user.cin = cin_controller.text;
                    widget.user.gstin = gstin_controller.text;
                    widget.user.contact = int.parse(contactno_controller.text);
                    widget.user.address = address_controller.text;
                    widget.user.pincode = int.parse(pincode_controller.text);
//              if(widget.user.type==1){
//                coll='fleet_owner';
//              }else if(widget.user.type==2){
//                coll='freight_owner';
//              }else{
//                coll='transporter';
//              }
                    await db.collection('users').add({
                      'name': widget.user.name,
                      'type': widget.user.type,
                      'cin': widget.user.cin,
                      'gstin': widget.user.gstin,
                      'contact_no': widget.user.contact,
                      'address': widget.user.address,
                      'pincode': widget.user.pincode
                    });
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Dash()));
                },
              ),
                  )
            ]))
          ],
        )));
  }
}
