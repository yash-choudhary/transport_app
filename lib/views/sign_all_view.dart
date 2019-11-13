import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/provider_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../themedata/color.dart';


final primaryColor = Mycolor.primaryCustom;

enum AuthFormType { signIn, signUp,signUp2,signUp3, reset }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;

  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _warning;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
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
        if (authFormType == AuthFormType.signIn) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed In with ID $uid");
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          print("Password reset email sent");
          _warning = "A password reset link has been sent to $_email";
          setState(() {
            authFormType = AuthFormType.signIn;
          });
        } else {
          String uid = await auth.createUserWithEmailAndPassword(
              _email, _password);
          print("Signed up with New ID $uid");
          Navigator.of(context).pushReplacementNamed('/signup2');
        }
      } catch (e) {
        print(e);
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(height: _height * 0.05),
              showAlert(),
              SizedBox(height: _height * 0.05),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildHeaderText(),
                    ),
                    SizedBox(height: _height * 0.12),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.8, 0.0, 0.8, 0.0),
                      child:Column(
                        children: buildInputs()+buildButtons(),
                      ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
//    Scaffold(
//      body: Container(
//        color: primaryColor,
//        height: _height,
//        width: _width,
//        child: ListView(
//          children: <Widget>[
//            SizedBox(height: _height * 0.080),
//            showAlert(),
//            SizedBox(height: _height * 0.025),
//            buildHeaderText(),
//            SizedBox(height: _height * 0.05),
//            Padding(
//              padding: const EdgeInsets.all(20.0),
//              child: Form(
//                key: formKey,
//                child: Column(
//                  children: buildInputs() + buildButtons(),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                _warning,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = "Create New Account";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else {
      _headerText = "Sign In";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(color: Mycolor.primaryCustom, fontSize: 50.0),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];
    if (authFormType == AuthFormType.reset) {
      textFields.add(
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
      );
      textFields.add(SizedBox(height: 20));
      return textFields;
    }else if (authFormType == AuthFormType.signIn || authFormType == AuthFormType.signUp) {
      textFields.add(
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
      );
      textFields.add(SizedBox(height: 20));
      textFields.add(
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
      );
      textFields.add(SizedBox(height: 20));
    }
    return textFields;
  }


//  InputDecoration buildSignUpInputDecoration(String hint) {
//    return InputDecoration(
//      hintText: hint,
//      filled: true,
//      fillColor: Colors.white,
//      focusColor: Colors.white,
//      enabledBorder: OutlineInputBorder(
//          borderRadius: const BorderRadius.all(
//            const Radius.circular(5.0),
//          ),
//          borderSide: BorderSide(color: Colors.white, width: 0.0)),
//      //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
//    );
//
//  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "Login";
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = "Return to Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
    } else {
      _switchButtonText = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }

    return [
      Center(
        child: ButtonTheme(
          minWidth: 200.0,
          height: 40.0,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              submit();
            },
            child: Text(
              _submitButtonText,
              style:
              TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ),
      ),
      showForgotPassword(_showForgotPassword),
      FlatButton(
        child: Text(
          _switchButtonText,
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          "Forgot Password?",
        ),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }
}