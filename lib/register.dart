import 'package:flutter/material.dart';
import 'package:coffeecrew/auth.dart';
import 'package:coffeecrew/loading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: loading ? Loading() : Container(
        padding: EdgeInsets.fromLTRB(16, 80, 16, 80),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (val) => val.isEmpty ? 'enter email' : null,
                  decoration: InputDecoration(
                      hintText: 'Type Email',
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
                        hintText: 'Type Password',
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
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      try{
                        print(email);
                        print(password);
                        await _auth.registerUser(email: email.trim(), password: password);
                        setState(() {
                          loading = false;;
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
                    'Register',
                    style: TextStyle(
                        color: Colors.blue[0]
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'error occurred, try again',
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
