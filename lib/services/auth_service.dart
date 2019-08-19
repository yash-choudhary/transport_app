import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
          (FirebaseUser user) => user?.uid,
  );

  //Email & Password Sign up
  Future<String> createUserWithEmailAndPassword(String email, String password) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    //To Update UserName
//    var userUpdateInfo = UserUpdateInfo();
//    userUpdateInfo.displayName = name;
//    await currentUser.user.updateProfile(userUpdateInfo);
//    await currentUser.user.reload();
    return currentUser.user.uid;
  }

  //Email and Password Sign In
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user.uid;
  }

  //Sign Out
  signOut(){
    return _firebaseAuth.signOut();
  }

  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

   Future<String> getCurrentUID() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final uid = user.uid;
    return uid;
  }
  Future<String> getCurrentEmail() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final email = user.email;
    return email;
  }

}

class EmailValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "Email can't be empty.";
    }else{
      return null;
    }
  }
}
class NameValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "Company name can't be empty.";
    }else{
      return null;
    }
  }
}

class FriendidValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "UserID can't be empty.";
    }else{
      return null;
    }
  }
}

class CinValidator{
  static String validate(String value){
//    Pattern pattern =
//        r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
//    RegExp regex = new RegExp(pattern);
//    if (!regex.hasMatch(value))
//      return 'Enter Valid Phone Number';
//    else
//      return null;
    if(value.isEmpty){
      return "CIN can't be empty.";
    }else if(value.length >= 1/*21*/){
      return null;
    }else{
      return "Invalid CIN";
    }
  }
}
class GstinValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "GSTIN can't be empty.";
    }else if(value.length >= 1/*15*/){
      return null;
    }else{
      return "Invalid GSTIN";
    }
  }
}
class AddressValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "Address can't be empty.";
    }else{
      return null;
    }
  }
}
class ContactnoValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "Contact Number can't be empty.";
    }else{
      return null;
    }
  }
}
class PincodeValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "Pincode can't be empty.";
    }else if(value.length >= 1){
      return null;
    }else{
      return "Invalid Pincode";
    }
  }
}


class PasswordValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "Password can't be empty.";
    }else if(value.length <6){
      return "Password should be longer than 6 characters.";
    }else{
      return null;
    }
  }
}