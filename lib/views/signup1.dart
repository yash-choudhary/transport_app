import 'package:flutter/material.dart';
import 'package:transport_app/services/auth_service.dart';
import '../widgets/provider_widget.dart';
import 'signup3.dart';
import '../models/user_model.dart';
import '../widgets/text_field.dart';
import 'signup2.dart';
import '../views/dashboard.dart';
import 'package:flutter/services.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  get screenwidth => MediaQuery.of(context).size.width;
  get screenheight => MediaQuery.of(context).size.height;
  String _email, _password, _confirmpassword, _error;
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
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        String uid =
            await auth.createUserWithEmailAndPassword(_email, _password);
        print('Signed Up: ${uid}');
        print('user auth:${auth.getCurrentUser()}');
        Navigator.pushReplacementNamed(context, '/signup2');
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
        child: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: screenheight * 0.075),
              showAlert(),
              SizedBox(height: screenheight * 0.075),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'SIGNUP',
                    style: TextStyle(color: Colors.blue, fontSize: 50.0),
                  ),
                  SizedBox(height: screenheight * 0.04),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: TextFormField(
                      //key: key,
                      validator: EmailValidator.validate,
                      decoration: InputDecoration(
                          labelText: 'Enter Email',
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: TextFormField(
                      //key: key,
                      validator:PasswordValidator.validate,
                      decoration: InputDecoration(
                          labelText: 'New Password',
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
                  SizedBox(height: screenheight * 0.04),
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
                          'SIGNUP',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
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
