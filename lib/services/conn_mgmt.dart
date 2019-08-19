import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';
import '../widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/user_model.dart';

class SendRequest{
//  String _uid,_friendid;
//  static BuildContext context;

  static _uidsame(uid,friendid){
    return uid.toString().trim()==friendid.toString().trim();
  }

  static checkIfExistOrNot(String friendid,String uid,BuildContext context) async{
    if(!_uidsame(uid, friendid)){
      DocumentSnapshot fds = await Firestore.instance.collection("users")
          .document(friendid.toString().trim())
          .get();
      DocumentSnapshot uds = await Firestore.instance.collection("users")
          .document(uid.toString().trim())
          .get();
      DocumentSnapshot uds_frd = await Firestore.instance.collection("users")
          .document(uid.toString().trim()).collection("friendrequests").document(friendid).get();
      bool fexists = await fds.exists;
      await print(fexists);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: AutoSizeText(
              fexists ? "Confirm" : "User Does Not Exist!", maxLines: 1,),
            content: AutoSizeText(fexists
                ? "Send Request to ${fds['name']} (${fds['category'].toString().toUpperCase()})?"
                : "Check UserID Again.", maxLines: 1),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Align(
                alignment: Alignment.bottomLeft,
                child: FlatButton(
                  child: AutoSizeText("Cancel", maxLines: 1),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              FlatButton(
                child: AutoSizeText(fexists ? "Send" : "Ok", maxLines: 1),
                onPressed: () {
                  if (fexists) {
                    _sendRequest(uid,friendid,uds,fds);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Sent!'),
                    ));
                  }
                  else {
                    Navigator.of(context).pop();

                  }
                },
              ),
            ],
          );
        },
      );
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: AutoSizeText(
              "Can't send request to yourself.", maxLines: 1,),
            content: AutoSizeText("Please provide UserID other than yourself.", maxLines: 2),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              FlatButton(
                child: AutoSizeText("Ok", maxLines: 1),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  static _sendRequest(String uid,String friendid,DocumentSnapshot uds,DocumentSnapshot fds)async{
    //1: Sent
    //2: Received
    try {
      await Firestore.instance.collection("users").document(uid).collection(
          "friendrequests").document(friendid).setData({
        'type': "sent",
        'name':fds['name'].toString(),
        'category':fds['category'].toString(),
        'uid':friendid.toString()

      });
      await Firestore.instance.collection("users").document(friendid)
          .collection("friendrequests").document(uid)
          .setData({
        'type': "received",
        'name':uds['name'].toString(),
        'category':uds['category'].toString(),
        'uid':uid.toString()
      });

    }
    catch(e){
      print(e);
    }
  }

}


class AcceptRequests{
  final _uid = usermodel.uid;



}