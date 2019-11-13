import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../services/conn_mgmt.dart';
import '../services/auth_service.dart';
import '../themedata/color.dart';

class AddDialog extends StatelessWidget {
  final primaryColor = Mycolor.primaryCustom;
  final grayColor = const Color(0xFF939393);

  final String title,
      description,
      primaryButtonText,
      primaryButtonRoute,
      secondaryButtonText,
      secondaryButtonRoute,uid;

  //static formKey1 = GlobalKey<FormState>();
  static GlobalKey<FormState> formKey1 = new GlobalKey<FormState>();
  String friendid;
  bool validate() {
    final form = formKey1.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  AddDialog(
      {@required this.uid,
        @required this.title,
      @required this.description,
      @required this.primaryButtonText,
      @required this.primaryButtonRoute,
      this.secondaryButtonText,
      this.secondaryButtonRoute});

  static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      child: Stack(
        children: <Widget>[
          ListView(shrinkWrap: true, children: <Widget>[
            Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(padding),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ]),
              child: Form(
                key: formKey1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    SizedBox(height: 24.0),
                    AutoSizeText(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    AutoSizeText(
                      description,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: grayColor,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    TextFormField(
                      //key: key,
                      validator: FriendidValidator.validate,
                      decoration: InputDecoration(
                          labelText: 'Enter UserID',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
                          fillColor: Colors.white70),
                      onSaved: (value) => friendid = value,
                      autofocus: false,
                      obscureText: false,
                    ),
                    RaisedButton(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: AutoSizeText(
                          primaryButtonText,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (validate()) {
                          var opt = SendRequest.checkIfExistOrNot(friendid,uid,context);
                          print(opt);
                        }
                      },
                    ),
                    SizedBox(height: 10.0),
                    showSecondaryButton(context),
                  ],
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  showSecondaryButton(BuildContext context) {
    if (secondaryButtonRoute != null && secondaryButtonText != null) {
      return FlatButton(
        child: AutoSizeText(
          secondaryButtonText,
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
            color: primaryColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(secondaryButtonRoute);
        },
      );
    } else {
      return SizedBox(height: 10.0);
    }
  }
}
