import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_flow/constants.dart';
import 'package:flutter_auth_flow/provider/provider_loading.dart';
import 'package:flutter_auth_flow/screens/home_screen.dart';
import 'package:flutter_auth_flow/screens/signup_screen.dart';
import 'package:flutter_auth_flow/services/authen.dart';
import 'package:flutter_auth_flow/widgets/custom_button.dart';
import 'package:flutter_auth_flow/widgets/custom_textField.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controllerEmail = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  String email , password;
  bool _security = true;
  Auth _auth = Auth();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
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
              right: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/login_bottom.png',
                width: size.width * 0.3,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    SvgPicture.asset(
                      'assets/icons/login.svg',
                      height: size.height * 0.35,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            text: 'You Email',
                            controlles: _controllerEmail,
                            security: false,
                            icon: Icons.person,
                            onPress: (value) {
                              if(value.isEmpty || !value.contains('@')){
                                return 'Please enter email address';
                              }
                              return null;
                            },
                            saved: (value) {
                               email  = value;
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          CustomTextField(
                            text: 'Password',
                            security: _security,
                            icon: Icons.lock,
                            iconShow: _security ?  Icons.visibility : Icons.visibility_off,
                            tap: () {
                              setState(() {
                                _security = !_security;
                              });
                            },
                            onPress: (value) {
                              if(value.isEmpty || value.length < 6) {
                                return 'Please enter password or adding greater then 6 character';
                              }
                              return null;
                            },
                            saved: (value) {
                              password = value;
                            },
                          ),
                          CustomButton(
                            title: 'LOGIN',
                            color: kPrimaryColor,
                            textColor: Colors.white,
                            onPress: () async{
                              FocusScope.of(context).unfocus();
                              final modalProvider = Provider.of<LoadingProvider>(context, listen: false);
                               if(!_formKey.currentState.validate()){
                                 return;
                               }
                               modalProvider.changeLoading(true);
                               _formKey.currentState.save();
                               await _auth.signIn(email.trim(), password.trim());
                               modalProvider.changeLoading(false);
                               Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an Account ? ',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
