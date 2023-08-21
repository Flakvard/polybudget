import 'package:firebase_auth/firebase_auth.dart';
import 'package:polybudget/database.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';

class AuthService {

  FirebaseAuth get _auth => FirebaseAuth.instance;

  // create user object based on FireBaseUser
  MyUser? _userFromFirebaseUser(User? user){
    return user != null ? MyUser(uid: user.uid, ) : null;
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

  // auth change user stream
  // return null if signed out and uid if signed in
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
        // this below
        //.map(_userFromFirebaseUser);
        // is the same as this below
        //.map((User? user) => _userFromFirebaseUser(user!));
  }

  // sign in email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }



  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      // register a new user
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // get the user back and collect the uid
      User? user = result.user;
      // creates the user in the database.
      final DatabaseService db = DatabaseService(uid: user!.uid);
      // Create a new document for the user with the uid
      await db.updateUserData(name: 'new member', email: email);

      // creates the MyUser class and returns user or Null
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}