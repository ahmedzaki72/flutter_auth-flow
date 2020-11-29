import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/constants.dart';
import 'package:flutter_auth_flow/provider/provider_loading.dart';
import 'package:flutter_auth_flow/screens/home_screen.dart';
import 'package:flutter_auth_flow/screens/login_screen.dart';
import 'package:flutter_auth_flow/screens/signup_screen.dart';
import 'package:flutter_auth_flow/screens/welcome_screen.dart';
import 'package:flutter_auth_flow/services/authen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Auth auth = Auth();
  String token;

  void getToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final tokens = prefs.getString('token');
    setState(() {
      token = tokens;
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoadingProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Auth',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: token != null ? HomeScreen() :  WelcomeScreen(),
          routes: {
            WelcomeScreen.routeName : (context) => WelcomeScreen(),
            LoginScreen.routeName : (context) => LoginScreen(),
            SignUpScreen.routeName : (context) => SignUpScreen(),
            HomeScreen.routeName : (context) => HomeScreen(),
          },
        ),
    );
  }
}

