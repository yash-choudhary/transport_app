import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../models/user_model.dart';
import '../themedata/color.dart';


class Profile{
  static profileviewer(String id,BuildContext context)async{
    DocumentSnapshot fds = await Firestore.instance.collection("users")
        .document(id.toString().trim())
        .get();
    return await null ;
  }
}
