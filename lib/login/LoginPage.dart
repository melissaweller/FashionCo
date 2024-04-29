import 'package:flutter/material.dart';
import 'package:project/models/FirebaseAuthService.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Navigation.dart';
import '../models/UserModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    var user = await _auth.login(email, password);

    if(user != null){
      print("User has been successfully signed in");

      String? username = await getIdByEmail(_emailController.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Navigation(username: username)));

      // Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your email or password is invalid. Please try again.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.pink[400],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/logo.png', height: 75, width: 75),
            ),
            SizedBox(height: 60,),
            Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text('Login', style: TextStyle(fontSize: 30),),
                    SizedBox(height: 10,),
                    Text('Sign in to continue', style: TextStyle(fontSize: 14),),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.email_outlined, color: Colors.pink[400],),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.lock_open, color: Colors.pink[400],),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.pink[400],
                            minimumSize: Size(300, 40)
                        ),
                        onPressed: (){
                          _login();
                        },
                        child: Text('LOGIN')
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> getIdByEmail(String email) async {
  String? username;

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userModel = UserModel.fromSnapshot(querySnapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>);
      username = userModel.username;
    }
  } catch (error) {
    print('Error getting username: $error');
  }

  return username;
}