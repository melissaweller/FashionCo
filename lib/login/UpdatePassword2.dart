import 'package:flutter/material.dart';
import 'package:project/login/LoginPage.dart';

class updatePassword2 extends StatefulWidget {
  const updatePassword2({super.key});

  @override
  State<updatePassword2> createState() => _ForgetPSW2State();
}

class _ForgetPSW2State extends State<updatePassword2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fashion Co.'),
          backgroundColor: Colors.pink[400],
          centerTitle: true,
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Password Reset Email Sent", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text("Please click on the link provided in the email to change your password. Once the password has been changed you may reattempt to loginm", style: TextStyle(fontSize: 24, color: Colors.grey),),
                  SizedBox(height: 20,),
                  SizedBox(
                      width: 350,
                      child : ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Text("Return to Login", style: TextStyle(fontSize: 20),),
                      )
                  )
                ]
            )
        )
    );
  }
}