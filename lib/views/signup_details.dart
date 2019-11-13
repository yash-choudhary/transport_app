import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/provider_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard.dart';
import '../widgets/provider_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../themedata/color.dart';


enum AuthFormType2 {signUp2,signUp3}

class SignUpView2 extends StatefulWidget {
  final AuthFormType2 authFormType;

  SignUpView2({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpView2State createState() =>
      _SignUpView2State(authFormType: this.authFormType);
}

class _SignUpView2State extends State<SignUpView2> {
  AuthFormType2 authFormType;

  _SignUpView2State({this.authFormType});

  static GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String name_controller,cin_controller,gstin_controller,contactno_controller,address_controller,pincode_controller, _warning, _category;
  int _type;
  final db = Firestore.instance;
  String coll;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp2") {
      setState(() {
        authFormType = AuthFormType2.signUp2;
      });
    } else {
      setState(() {
        authFormType = AuthFormType2.signUp3;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider
            .of(context)
            .auth;
        if (authFormType == AuthFormType2.signUp2) {
          authFormType = AuthFormType2.signUp3;
        } else {
          final uid = await auth.getCurrentUID();
          print("22222"+uid);

            if(_type==1){
              _category= "Fleet Owner";
            }else if(_type==2){
              _category= "Transporter";
            }else{
              _category= "Freight Owner";
            }
          await db.collection('users').document(uid/*cin_controller*/).setData({
            'name': name_controller,
            'type': _type,
            'category':_category,
            'cin': cin_controller,
            'gstin': gstin_controller,
            'contact_no': contactno_controller,
            'address': address_controller,
            'pincode': pincode_controller
          });
//          await db.collection('uids').document(uid).setData({
//            'cin': cin_controller,
//            'gstin': gstin_controller,
//          });
          print("Updated");
          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery
        .of(context)
        .size
        .width;
    final _height = MediaQuery
        .of(context)
        .size
        .height;

    if (authFormType == AuthFormType2.signUp2) {
      return WillPopScope(
        onWillPop: ()async=>false,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Company Type',
                  style: TextStyle(fontSize: 30.0, color: Mycolor.primaryCustom),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.white,
                    onPressed: () {
                      _type = 1;
                      setState(() {
                        authFormType = AuthFormType2.signUp3;
                      });

                    },
                    child: Text(
                      'Fleet Owner',
                      style: TextStyle(fontSize: 18.0, color: Mycolor.primaryCustom),
                    ),
                  ),
                ),
              ),
              Center(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.white,
                    onPressed: () {
                      _type = 2;
                      setState(() {
                        authFormType = AuthFormType2.signUp3;
                      });
                    },
                    child: Text(
                      'Transporter',
                      style: TextStyle(fontSize: 18.0, color: Mycolor.primaryCustom),
                    ),
                  ),
                ),
              ),
              Center(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.white,
                    onPressed: () {
                      _type = 3;
                      setState(() {
                        authFormType = AuthFormType2.signUp3;
                      });
                    },
                    child: Text(
                      'Freight Owner',
                      style: TextStyle(fontSize: 18.0, color: Mycolor.primaryCustom),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Registration'),
            centerTitle: true,
          ),
          body: Center(
              child: Form(
                onWillPop: ()async=>false,
                key: formKey,
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
                          validator: NameValidator.validate,
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
                          validator: CinValidator.validate,
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
                          validator: GstinValidator.validate,
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
                          validator: ContactnoValidator.validate,
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
                        validator: AddressValidator.validate,
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
                          validator: PincodeValidator.validate,
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
                              color: Mycolor.primaryCustom,
                              child: new Text('Submit',style: TextStyle(fontSize: 18.0, color: Colors.white),),
                              onPressed: () async {
                                submit();
                              },
                            ),
                          )
                        ]))
                  ],
                ),
              )));
    }
  }
}