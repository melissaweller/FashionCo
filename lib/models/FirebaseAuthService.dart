import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  // Register User with Firebase Authentication
  Future<User?> register(String email, String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print("An error occured : ${e}");
    }
    return null;
  }

  // Login using Firebase Authentication
  Future<User?> login(String email, String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print("An error occured : ${e}");
    }
    return null;
  }

  Future<void> sendPasswordResetEmail(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e){
      print("An error occured : ${e}");
    }
  }

}