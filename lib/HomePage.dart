import 'package:flutter/material.dart';
import 'login/LoginPage.dart';
import 'login/SignUpPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/logo.png', height: 75, width: 75),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(' Fashion Co.', style: TextStyle(fontSize: 24),),
            ),
            SizedBox(height: 150,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.pink[400],
                    minimumSize: Size(300, 40)
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text('Login')
            ),
            SizedBox(height: 10,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.pink[400],
                    minimumSize: Size(300, 40)
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: Text('Sign Up')
            ),
          ],
        ),
      ),
    );
  }
}