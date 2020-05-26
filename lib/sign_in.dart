import 'package:coffeecrew/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffeecrew/authenticate.dart';
import 'package:coffeecrew/loading.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final FirebaseAuth _fbauth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool loading = false;
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[100],
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 80, 16, 80),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter Email' : null,
                  decoration: InputDecoration(
                    labelText: 'Email'
                  ),
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  validator: (val) => val.length < 6 ? 'enter password of 6+ length' : null,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password'
                  ),
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  }
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.grey[200],
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      try{
                        print(email);
                        print(password);
                        dynamic result = await _fbauth.signInWithEmailAndPassword(email: email.trim(), password: password);
                        setState(() {
                          loading = false;
                        });
                      }
                      catch(e){
                        print(e.toString());
                        setState(() {
                          loading = false;
                          error = e.toString();
                        });
                      }
                    }
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.blue[0]
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
