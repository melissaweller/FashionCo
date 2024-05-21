import 'package:flutter/material.dart';
import '../models/FirebaseAuthService.dart';
import 'ForgotPasswordConfirmation.dart';
import 'LoginPage.dart';

class updatePassword extends StatefulWidget {
  final String? userId;
  const updatePassword({required this.userId});

  @override
  State<updatePassword> createState() => _UpdatePSW1State();
}

class _UpdatePSW1State extends State<updatePassword> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _email = TextEditingController();

  sendPasswordResetEmail() async {

    try {
      if (_email.text != null) {
        _auth.sendPasswordResetEmail(_email.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An email has been sent to reset your password")));
        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordConfirmation()));
      }
    }
    catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error has occured ${e}")));
    }
  }

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
                Text("Change Password", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(20),
                  child :TextField(
                    controller: _email,
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
                ),
                SizedBox(height: 20),
                SizedBox(
                    width: 350,
                    child : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.pink[400],
                          minimumSize: Size(300, 40)
                      ),
                      onPressed: (){
                      sendPasswordResetEmail();
                    }, child: Text("Send Email", style: TextStyle(fontSize: 20),),
                    )
                ),
                SizedBox(height: 10),
                SizedBox(
                    width: 350,
                    child : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.pink[400],
                          minimumSize: Size(300, 40)
                      ),
                      onPressed: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()),
                              (route) => false);
                    }, child: Text("Cancel", style: TextStyle(fontSize: 20),),
                    )
                ),
              ],
            )
        )
    );
  }
}