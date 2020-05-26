import 'package:coffeecrew/auth.dart';
import 'package:coffeecrew/brewList.dart';
import 'package:coffeecrew/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coffeecrew/loading.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeecrew/brew.dart';
import 'package:coffeecrew/settingsForm.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  AuthService instance = AuthService();

  @override
  Widget build(BuildContext context) {

    _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
          );
        });
    }

    return StreamProvider<List<Brew>>.value (
      value: DatabaseService().brew,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
              label: Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
            ),
              icon: Icon(
              Icons.settings
            ),
              onPressed: _showSettingsPanel
            ),
            FlatButton.icon(
              onPressed: () async{
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.grey[250],
              ),
              label: Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold                ),
              )
            )
          ],
          title: Text(
            'Coffee Crew'
          ),
        ),
        body: BrewList(),
      ),
    );
  }
}
