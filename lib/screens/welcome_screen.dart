import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/widgets/body_widget.dart';


class WelcomeScreen extends StatelessWidget {
  static const String routeName = 'Welcome_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyWidget(),
    );
  }
}
