import 'package:flutter/material.dart';

import 'LoginPage.dart';

class ForgotPasswordConfirmation extends StatefulWidget {
  const ForgotPasswordConfirmation({super.key});

  @override
  State<ForgotPasswordConfirmation> createState() => _ForgotPasswordConfirmationState();
}

class _ForgotPasswordConfirmationState extends State<ForgotPasswordConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fashion Co.'),
          backgroundColor: Colors.pink[400],
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Password Reset Email Sent", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text("Please click on the link provided in the email to change your password.", style: TextStyle(fontSize: 20, color: Colors.black),),
                SizedBox(height: 20,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.pink[400],
                        minimumSize: Size(300, 40)
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child:Text("Return to Login", style: TextStyle(fontSize: 20),)
                ),
              ]
          ),
        )
    );
  }
}