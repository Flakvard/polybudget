import 'package:firebase_auth/firebase_auth.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FireBaseUser

  MyUser? _userFromFirebaseUser(User user){
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // sign in anon

  Future signInAnon() async {
    try {
      UserCredential result =  await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e) {
      print(e.toString());
      return null;
    }

  }

  // sign in email and password


  // register with email and password


  // sign out

}