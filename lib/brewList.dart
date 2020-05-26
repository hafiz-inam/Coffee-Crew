import 'package:coffeecrew/brewTile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeecrew/database.dart';
import 'package:provider/provider.dart';
import 'package:coffeecrew/brew.dart';


class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
    return Scaffold(resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: brews.length,
          itemBuilder: (context, index){
            return BrewTile(brew: brews[index]);
          },
        ),
      )
    );
  }
}
