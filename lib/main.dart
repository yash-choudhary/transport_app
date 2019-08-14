import 'package:flutter/material.dart';
import 'views/signup.dart';
import 'views/registration_primary.dart';
import 'views/login_signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
//        primaryColor: Color(0xff20B2AA),
//        accentColor: Color(0xff2C393F),
        buttonColor: Colors.blue,
//        backgroundColor: Color(0xffE5E5E5),

        //backgroundColor: Color(0xffEDEDED),
        // Define the default font family.
        fontFamily: 'Montserrat',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      initialRoute: '/login',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/registration': (context) => Registration(),
        '/login': (context) => LoginScreen()
      },
    );
  }
}

