import 'package:flutter/material.dart';
import '../models/FirebaseAuthService.dart';
import 'ForgotPasswordConfirmation.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();

  sendPasswordResetEmail() async {
    try {
      if (_emailController.text != null) {
        _auth.sendPasswordResetEmail(_emailController.text);
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
                Text("Forgot Password?", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(20),
                  child :TextField(
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
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.pink[400],
                        minimumSize: Size(300, 40)
                    ),
                    onPressed: (){
                      sendPasswordResetEmail();
                    },
                    child:Text("Send Email", style: TextStyle(fontSize: 20),)
                ),
              ],
            )
        )
    );
  }
}