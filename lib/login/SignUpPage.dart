import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/Notification.dart';
import 'LoginPage.dart';
import 'package:project/models/FirebaseAuthService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/models/UserModel.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _register() async {
    String name = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    var user = await _auth.register(email, password);

    if(user != null){
      NotificaionService().showNotification(1, 'User Creation', 'User has been successfully created');
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your password must be at least 6 characters.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.pink[400],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/logo.png', height: 50, width: 50),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(20),
                height: 450,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text('Create a New Account', style: TextStyle(fontSize: 25),),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap:(){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginPage()), (route) => false);
                      },
                      child: Text('Already have an account? Sign In', style: TextStyle(color: Colors.pink[900], fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        prefixIcon: Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.person_2_outlined, color: Colors.pink[400],),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
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
                      obscureText: true,
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
                    SizedBox(height: 10,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.pink[400],
                            minimumSize: Size(300, 40)
                        ),
                        onPressed: (){
                          _addUserToDb(new UserModel(
                            username: _usernameController.text,
                            email : _emailController.text,
                          ));
                          _register();
                        },
                        child: Text('SIGN UP')
                    ),
                    SizedBox(height: 10,),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}

void _addUserToDb(UserModel userModel) {
  final userCollection = FirebaseFirestore.instance.collection("Users");

  String id = userCollection
      .doc()
      .id;

  final newUser = UserModel(
    username: userModel.username,
    email: userModel.email,
    id: id,
  ).toJson();

  userCollection.doc(id).set(newUser);
}

