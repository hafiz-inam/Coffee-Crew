import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffeecrew/user.dart';
import 'package:coffeecrew/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map((_userFromFirebaseUser));
  }

  registerUser({String email, String password}) async{
    try{

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      DatabaseService(uid: user.uid).updateUserData('New User', '0', 100);
      return _userFromFirebaseUser(user);

    }
    catch(e){

      print(e.toString());
      return null;

    }
  }

  signInWithEmailAndPassword({String email, String password}) async{
    String emailVal = email;
    String passVal = password;
//    print(emailVal);
//    print(passVal);
    try{

      AuthResult result = await _auth.signInWithEmailAndPassword(email: emailVal, password: passVal);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }
    catch(e){

      print(e.toString());
      return null;

    }
  }

  signOut() async{
    try{
      await _auth.signOut();
    }
    catch (e){
      print(e.toString());
    }
  }

}