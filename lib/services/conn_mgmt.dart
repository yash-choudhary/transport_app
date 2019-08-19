import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_service.dart';
import '../widgets/provider_widget.dart';

class SendRequest{
  String _uid,_friendid;

  static checkIfLikedOrNot(friendid) async{
    DocumentSnapshot ds = await Firestore.instance.collection("users").document(friendid.toString().trim()).get();
    print(ds.exists);
    return ds.exists;
  }

  static uidnotsame(uid,friendid){
    return uid.toString().trim()==friendid.toString().trim();
  }



}