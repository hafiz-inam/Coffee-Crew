import 'dart:io';

import 'package:coffeecrew/brewTile.dart';
import 'package:coffeecrew/database.dart';
import 'package:flutter/material.dart';
import 'brew.dart';
import 'package:coffeecrew/brewTile.dart';
import 'package:provider/provider.dart';
import 'package:coffeecrew/user.dart';
import 'loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _key = GlobalKey<FormState>();
  final List<String> sugars =  ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
//    DatabaseService(uid: user.uid).updateUserData('Hafiz', '0', 100);

    return StreamBuilder<UserData>(

      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;

        if(snapshot.hasData){

          print(userData.name);
          print(userData.sugar);
          print(userData.strength);

          return Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Update Settings')
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                    onChanged: (val) => setState(() => _currentName = val ),
                    validator: (val) => val.isEmpty ? 'Enter Name' : null,
                  ),
                  SizedBox(height: 20.0,),
                  DropdownButtonFormField(
                    value: userData.sugar,
                    items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState (() => _currentSugar = val),
                  ),
                  SizedBox(height: 20.0,),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentStrength = val.round()) ,
                  ),
                  RaisedButton(
                    child: Text('Update'),
                    onPressed: ()async{
                      if(_key.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentSugar ?? userData.sugar,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }

                    },
                  ),
                ],
              ),
            ),
          );

        }
        else{
          return Loading();
        }
      }
    );
  }
}
