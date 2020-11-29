import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/constants.dart';
import 'package:flutter_auth_flow/screens/login_screen.dart';
import 'package:flutter_auth_flow/screens/signup_screen.dart';
import 'package:flutter_auth_flow/widgets/custom_button.dart';
import 'package:flutter_svg/svg.dart';

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_top.png',
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_bottom.png',
              width: size.width * 0.2,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'WELCOME TO EDU',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03 ,),
                  SvgPicture.asset(
                    'assets/icons/chat.svg',
                    height: size.height * 0.45,
                  ),
                  SizedBox(height: size.height * 0.03 ,),
                  CustomButton(
                    onPress: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    title: 'LOGIN',
                    color: kPrimaryColor,
                    textColor: Colors.white,
                  ),
                  CustomButton(
                    onPress: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    title: 'SIGNUP',
                    textColor: Colors.black,
                    color: kPrimaryLightColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

