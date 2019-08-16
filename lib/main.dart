import 'package:flutter/material.dart';
//import 'views/signup1.dart';
import 'views/signup2.dart';
import 'views/signup3.dart';
import 'views/login_signup.dart';
import 'views/dashboard.dart';
import 'views/first_view.dart';
import 'views/singn_all_view.dart';
import 'package:transport_app/services/auth_service.dart';
import 'widgets/provider_widget.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
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
        home: HomeController(),
        //initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/home': (BuildContext context) => HomeController(),
          '/signup2': (BuildContext context)=> signup2(),
          '/signup3': (BuildContext context)=> signup3(),
        },
//        {
//          // When navigating to the "/" route, build the FirstScreen widget.
//          '/home': (context) => HomeController(),
//          '/login': (context) => LoginScreen(),
//          //'/signup': (context)=> SignUpView(),
//          '/signup2': (context)=> signup2(),
//          '/signup3': (context)=> signup3(),
//          '/dashboard': (context) => Dash(),
//        },
      ),
    );
  }
}


class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          final bool signedIn = snapshot.hasData;
          return signedIn ? Dash():FirstView()/*LoginScreen()*/;
        }
        return CircularProgressIndicator();
        }
    );
  }
}


