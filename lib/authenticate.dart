import 'package:coffeecrew/register.dart';
import 'package:flutter/material.dart';
import 'package:coffeecrew/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool registered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: Text("Coffee Crew"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              setState(() {
                if(registered){
                  registered = false;
                }
                else{
                  registered = true;
                }
              });
            },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text(
              registered ? 'Register' : 'Sign In',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            )
          ),
        ],
      ),
      body: Scaffold(
        body: registered ? SignIn() : Register(),
      ),
    );
  }
}
