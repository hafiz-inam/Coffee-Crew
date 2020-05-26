import 'package:coffeecrew/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffeecrew/wrapper.dart';
import 'package:coffeecrew/home.dart';
import 'package:coffeecrew/sign_in.dart';
import 'package:coffeecrew/register.dart';
import 'package:provider/provider.dart';
import 'package:coffeecrew/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}


