import 'package:flutter/material.dart';
import '../widgets/provider_widget.dart';
import 'signup3.dart';
import '../models/user_model.dart';
import '../widgets/text_field.dart';
import 'signup2.dart';
import '../views/dashboard.dart';
import 'package:flutter/services.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  usermodel newuser;
  get screenwidth => MediaQuery.of(context).size.width;
  get screenheight => MediaQuery.of(context).size.height;
  String _email, _password,_error;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final formkey = GlobalKey<FormState>();

  bool validate() {
    final form = formkey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()){
      try {
        final auth = Provider
            .of(context)
            .auth;
        String uid = await auth.signInWithEmailAndPassword(_email, _password);
        print('Signed In: ${uid}');
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });
      }
  }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.error_outline),
            Expanded(
                child: Text(
                  _error,
                  maxLines: 3,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(icon: Icon(Icons.close), onPressed: (){
                setState(() {
                  _error=null;
                });
              }),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(height: screenheight * 0.05),
              showAlert(),
              SizedBox(height: screenheight * 0.05),
              Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome',
                      style: TextStyle(color: Colors.blue, fontSize: 50.0),
                    ),
                    SizedBox(height: screenheight * 0.12),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.8, 0.0, 0.8, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: TextFormField(
                          //key: key,
                          validator: EmailValidator.validate,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
                              fillColor: Colors.white70),
                          onSaved: (value) => _email = value,
                          autofocus: false,
                          obscureText: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.8, 0.0, 0.8, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        child: TextFormField(
                          //key: key,
                          validator:PasswordValidator.validate,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(icon: Icon(_obscureText? Icons.visibility:Icons.visibility_off), onPressed: (){
                                _toggle();
                              }),
                              border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                ),
                              ),
                              filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
                              fillColor: Colors.white70),
                          onSaved: (value) => _password = value,
                          autofocus: false,
                          obscureText: _obscureText,
                        ),
                      ),
                    ),
                    SizedBox(height: screenheight * 0.05),
                    Center(
                      child: ButtonTheme(
                        minWidth: 150.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: () {
                            submit();
                          },
                          child: Text(
                            'LOGIN',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
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
                    SizedBox(height: screenheight * 0.01),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('New User? Please Register...'),
                    ),
                    Center(
                      child: ButtonTheme(
                        minWidth: 150.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/signup");
                          },
                          child: Text(
                            'SIGNUP',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
