import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/screens/login_screen.dart';
import 'package:flutter_auth_flow/services/authen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Welcome to my auth flow'),
          FlatButton(
            color: Colors.grey,
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.popAndPushNamed(context, LoginScreen.routeName);
            },
            child: Text('Logout',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
