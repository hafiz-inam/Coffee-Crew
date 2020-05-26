import 'package:flutter/material.dart';
import 'package:coffeecrew/brew.dart';

class BrewTile extends StatelessWidget {

  final  Brew brew;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(
            brew.name,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
        ),
          subtitle: Text('takes ${brew.sugar} sugar'),
        ),
      ),
    );
  }
}