import 'package:flutter/material.dart';
import 'registration_primary.dart';
import '../models/user_model.dart';
import '../widgets/text_field.dart';
import 'signup.dart';
import '../views/dashboard.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  usermodel newuser;
  get screenwidth => MediaQuery.of(context).size.width;
  get screenheight => MediaQuery.of(context).size.height;
  TextEditingController _email = new TextEditingController();

  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(height: screenheight*0.15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome',
                    style: TextStyle(color: Colors.blue, fontSize: 50.0),
                  ),
                  SizedBox(height: screenheight*0.04),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.8,0.0,0.8,0.0),
                    child: txtfield('Email', _email, false, false),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.8,0.0,0.8,0.0),
                    child: txtfield('Password', _password, false, true),
                  ),
                  Center(
                    child: ButtonTheme(
                      minWidth: 150.0,
                      height: 40.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Dash()));
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(fontSize:18.0 ,color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: FlatButton(
                          onPressed: () {
                            return null;
                          },
                          child: Text('Forgot Password? Click Here'))),
                  SizedBox(height: screenheight*0.01),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('New User? Please Register...'),
                  ),
                  Center(
                    child: ButtonTheme(
                      minWidth: 150.0,
                      height: 40.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(fontSize:18.0,color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
