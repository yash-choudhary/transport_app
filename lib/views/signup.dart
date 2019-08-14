import 'package:flutter/material.dart';
import '../views/registration_primary.dart';
import '../models/user_model.dart';

class Home extends StatelessWidget {
  usermodel newuser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Company Type',
              style: TextStyle(fontSize: 30.0, color: Colors.blue),
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
                  newuser =
                      new usermodel(1, null, null, null, null, null, null);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Registration(user: newuser)));
                },
                child: Text(
                  'Fleet Owner',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
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
                  newuser =
                      new usermodel(2, null, null, null, null, null, null);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Registration(user: newuser)));
                },
                child: Text(
                  'Transporter',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
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
                  newuser =
                      new usermodel(3, null, null, null, null, null, null);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Registration(user: newuser)));
                },
                child: Text(
                  'Freight Owner',
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
