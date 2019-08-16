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

  getCurrentUser(){
    return _firebaseAuth.currentUser();
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

class PasswordValidator{
  static String validate(String value){
    if(value.isEmpty){
      return "Password can't be empty.";
    }else if(value.length <6){
      return "Password should be longer than 6 characters.";
    }
  }
}