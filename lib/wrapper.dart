import 'package:flutter/material.dart';
import 'package:coffeecrew/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:coffeecrew/user.dart';
import 'package:provider/provider.dart';
import 'package:coffeecrew/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null ) {
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
